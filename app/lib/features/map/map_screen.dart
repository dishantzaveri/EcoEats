import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:here_sdk/animation.dart' as anim;
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/gestures.dart';
import 'package:here_sdk/location.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/navigation.dart' as nav;
import 'package:here_sdk/routing.dart' as rout;
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';

import '../../logic/models/order_model.dart';
import '../../logic/models/rider_model.dart';
import '../../logic/stores/location_store.dart';
import '../../logic/stores/order_store.dart';
import '../../utils/const.dart';
import '../../utils/palette.dart';
import '../../utils/typography.dart';
import 'custom_map_styles.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

enum TtsState { playing, stopped, paused, continued }

class _MapScreenState extends State<MapScreen> {
  late final HereMapController _hereMapController;
  // final MapCamera _mapCamera;
  CustomMapStyleExample? customMapStyleExample;
  late LocationEngine _locationEngine;
  late LocationIndicator _locationIndicator;
  late rout.RoutingEngine _routingEngine;
  late double mylongit, mylatit;
  final List<MapPolyline> _mapPolylines = [];
  nav.VisualNavigator? _visualNavigator;
  nav.LocationSimulator? _locationSimulator;
  late rout.Route route;
  bool isNavigating = false;
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  var orders;
  var riders;
  List<rout.Waypoint> waypoints = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> stream;
  bool isFirstEvent = true;

  @override
  void initState() {
    super.initState();
    try {
      _locationEngine = LocationEngine();
    } on InstantiationException {
      throw ("Initialization of LocationEngine failed.");
    }
    try {
      _routingEngine = rout.RoutingEngine();
    } on InstantiationException {
      throw ("Initialization of RoutingEngine failed.");
    }
    //myLoc();
    orders = context.read<OrderStore>().orders.values.toList();
    riders = context.read<OrderStore>().riders.values.toList();
    // Get a reference to the collection.
    CollectionReference collection = firestore.collection('orders');

    // Get the stream of snapshots.
    stream = collection.snapshots();

    // Listen to the stream.
    stream.listen((QuerySnapshot snapshot) {
      if (isFirstEvent) {
        isFirstEvent = false;
        return;
      }
      // Check if a new document has been added.
      List<DocumentChange> documentChanges = snapshot.docChanges;
      if (documentChanges.any((change) => change.type == DocumentChangeType.added) && !isFirstEvent) {
        orders = context.read<OrderStore>().orders.values.toList();
        OrderModel ord = OrderModel.fromJson(documentChanges[0].doc.data() as Map<String, dynamic>);
        logger.d(ord);
        addMarker(_hereMapController, ord.sourceLatitude, ord.sourceLongitude, "assets/images/food.png");
        addMarker(_hereMapController, ord.destinationLatitude, ord.destinationLongitude, "assets/images/ecoeatspin.png");
        // waypoints.add(rout.Waypoint.withDefaults(GeoCoordinates(
        //     order.sourceLatitude, order.sourceLongitude)));
        waypoints.add(rout.Waypoint.withDefaults(GeoCoordinates(ord.destinationLatitude, ord.destinationLongitude)));
        // If a new document has been added, show a bottom modal screen.
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'A new order has been placed in your vicinity!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Would you like to club your delivery with this order to be more green and earn rewards?',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          //_onMapCreated(_hereMapController);
                          // Handle the Yes option here.
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        child: const Text('No'),
                        onPressed: () {
                          //_onMapCreated(_hereMapController);
                          // Handle the No option here.
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  Future _speak(String text) async {
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  @override
  // void dispose() {
  //   // Free HERE SDK resources before the application shuts down.
  //   SdkContext.release();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HereMap(onMapCreated: _onMapCreated),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: Image.asset(
            "assets/images/ecoeatspin.png",
            width: 30,
            height: 30,
          ),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Palette.secondary,
          backgroundColor: Palette.primary[100],
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          fabSize: ExpandableFabSize.small,
          foregroundColor: Palette.primary,
          backgroundColor: Palette.secondary,
          shape: const CircleBorder(),
        ),
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.edit),
            onPressed: () {
              // latit = mylatit + Random().nextDouble() * 0.1 - 0.005;
              // longit = mylongit + Random().nextDouble() * 0.1 - 0.005;
              // addMarker(_hereMapController, latit, longit,
              //     "assets/images/ecoeatspin.png");
              // logger.d(allMarkers[2].coordinates.latitude);
              // animateMarker(
              //     allMarkers[0],
              //     GeoCoordinates(allMarkers[2].coordinates.latitude,
              //         allMarkers[2].coordinates.longitude),
              //     durationMs: 10000);
              DocumentReference copyFrom = FirebaseFirestore.instance.collection('orders').doc('0Ur71HGoD54A2Sh5UA7U');
              DocumentReference copyTo = FirebaseFirestore.instance.collection('orders').doc('testme');

              copyFrom.get().then((value) {
                Map<String, dynamic> data = value.data() as Map<String, dynamic>;
                data['sourceLatitude'] = 0.0;
                data['sourceLongitude'] = 0.0;
                data['destinationLatitude'] = 1.0;
                data['destinationLongitude'] = 1.0;
                data['sourceName'] = "EGRHDTGJMFHDGTFSEASFGFH";
                copyTo.set(data);
                //logger.d(data);
              });
              orders = context.read<OrderStore>().orders.values.toList();
              logger.d(orders);
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.location_pin),
            onPressed: () {
              myLoc();
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.route),
            onPressed: () {
              addRoute();
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.navigation),
            onPressed: () async {
              isNavigating ? _visualNavigator!.stopRendering() : _startGuidance(route);
              isNavigating ? null : flutterTts.stop();
              setState(() {
                isNavigating = !isNavigating;
              });
              //await _speak();
            },
          ),
        ],
      ),
    );
  }

  _startGuidance(rout.Route route) {
    try {
      // Without a route set, this starts tracking mode.
      _visualNavigator = nav.VisualNavigator();
    } on InstantiationException {
      throw Exception("Initialization of VisualNavigator failed.");
    }

    // This enables a navigation view including a rendered navigation arrow.
    _visualNavigator!.startRendering(_hereMapController);

    // Hook in one of the many listeners. Here we set up a listener to get instructions on the maneuvers to take while driving.
    // For more details, please check the "navigation_app" example and the Developer's Guide.
    _visualNavigator!.maneuverNotificationListener = nav.ManeuverNotificationListener((String maneuverText) async {
      logger.d("ManeuverNotifications: $maneuverText");
      await _speak(maneuverText);
    });

    // Set a route to follow. This leaves tracking mode.
    _visualNavigator!.route = route;

    // VisualNavigator acts as LocationListener to receive location updates directly from a location provider.
    // Any progress along the route is a result of getting a new location fed into the VisualNavigator.
    _setupLocationSource(_visualNavigator!, route);
  }

  _setupLocationSource(LocationListener locationListener, rout.Route route) {
    try {
      // Provides fake GPS signals based on the route geometry.
      _locationSimulator = nav.LocationSimulator.withRoute(route, nav.LocationSimulatorOptions());
    } on InstantiationException {
      throw Exception("Initialization of LocationSimulator failed.");
    }

    _locationSimulator!.listener = locationListener;
    _locationSimulator!.start();
  }

  double _getRandom(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }

  void _animateToRoute(rout.Route route) {
    // The animation results in an untilted and unrotated map.
    double bearing = 0;
    double tilt = 0;
    // We want to show the route fitting in the map view with an additional padding of 50 pixels.
    Point2D origin = Point2D(50, 50);
    Size2D sizeInPixels = Size2D(_hereMapController.viewportSize.width - 100, _hereMapController.viewportSize.height - 100);
    Rectangle2D mapViewport = Rectangle2D(origin, sizeInPixels);

    // Animate to the route within a duration of 3 seconds.
    MapCameraUpdate update = MapCameraUpdateFactory.lookAtAreaWithGeoOrientationAndViewRectangle(route.boundingBox, GeoOrientationUpdate(bearing, tilt), mapViewport);
    MapCameraAnimation animation = MapCameraAnimationFactory.createAnimationFromUpdateWithEasing(update, const Duration(milliseconds: 3000), anim.Easing(anim.EasingFunction.inCubic));
    _hereMapController.camera.startAnimation(animation);
  }

  GeoCoordinates createRandomGeoCoordinatesInViewport() {
    GeoBox? geoBox = _hereMapController.camera.boundingBox;
    if (geoBox == null) {
      // Happens only when map is not fully covering the viewport as the map is tilted.
      logger.d("The map view is tilted, falling back to fixed destination coordinate.");
      return GeoCoordinates(mylatit, mylongit);
    }

    GeoCoordinates northEast = geoBox.northEastCorner;
    GeoCoordinates southWest = geoBox.southWestCorner;

    double minLat = southWest.latitude;
    double maxLat = northEast.latitude;
    double lat = _getRandom(minLat, maxLat);

    double minLon = southWest.longitude;
    double maxLon = northEast.longitude;
    double lon = _getRandom(minLon, maxLon);

    return GeoCoordinates(lat, lon);
  }

  int i = 0;
  List options = [rout.CarOptions, rout.TruckOptions, rout.PedestrianOptions, rout.ScooterOptions, rout.BicycleOptions, rout.EVCarOptions, rout.TaxiOptions, rout.BusOptions, rout.TaxiOptions];
  Future<void> addRoute() async {
    var startGeoCoordinates = GeoCoordinates(mylatit, mylongit);
    //var destinationGeoCoordinates = GeoCoordinates(latit, longit);
    var startWaypoint = rout.Waypoint.withDefaults(startGeoCoordinates);
    var destinationWaypoint = rout.Waypoint.withDefaults(GeoCoordinates(orders[3].destinationLatitude, orders[3].destinationLongitude));

    List<rout.Waypoint> initailPoints = [
      startWaypoint,
      // waypoint1,
      // waypoint2,
      destinationWaypoint
    ];

    waypoints.add(destinationWaypoint);
    List<rout.Waypoint> selectedWaypoints = [startWaypoint];
    rout.Route candidateRoute;

    _routingEngine.calculateCarRoute(initailPoints, rout.CarOptions(), (rout.RoutingError? routingError, List<rout.Route>? initialRouteList) async {
      if (routingError == null) {
        rout.Route initialRoute = initialRouteList!.first;
        double initialDistance = initialRoute.lengthInMeters.toDouble();
        for (var waypoint in waypoints) {
          var candidateWaypoints = [...selectedWaypoints, waypoint, destinationWaypoint];
          _routingEngine.calculateCarRoute(candidateWaypoints, rout.CarOptions(), (rout.RoutingError? routingError, List<rout.Route>? routeList) async {
            if (routingError == null) {
              candidateRoute = routeList!.first;
              double candidateDistance = candidateRoute.lengthInMeters.toDouble();

              // Check if adding the waypoint increases the route length by a certain threshold (e.g., 10%).
              double threshold = 1.5;
              if (candidateDistance < initialDistance * threshold) {
                // Include the waypoint in the selected waypoints list.
                selectedWaypoints.add(waypoint);

                // Update the map and visualization as needed.
                // _animateToRoute(candidateRoute);
                // _showRouteDetails(candidateRoute);
                // _showRouteOnMap(candidateRoute);
                // _logRouteViolations(candidateRoute);
                setState(() {
                  route = candidateRoute;
                });
                //_startGuidance(candidateRoute);
              }
            }
          });
        }
        _animateToRoute(route);
        _showRouteDetails(route);
        _showRouteOnMap(route);
        _logRouteViolations(route);
      } else {
        var error = routingError.toString();
        _showDialog('Error', 'Error while calculating a route: $error');
        logger.d(error);
      }
    });
    i++;
  }

  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _markerPopup(String title, String message, String imageUrl, String qty, String price, String status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          //title: ,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/foods/${Random().nextInt(6) + 1}.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(title,
                      style: Typo.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(message),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Quantity: $qty'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Price: $price'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Status: $status'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logRouteViolations(rout.Route route) {
    for (var section in route.sections) {
      for (var notice in section.sectionNotices) {
        logger.d("This route contains the following warning: ${notice.code}");
      }
    }
  }

  _showRouteOnMap(rout.Route route) {
    // Show route as polyline.
    GeoPolyline routeGeoPolyline = route.geometry;
    double widthInPixels = 20;
    Color polylineColor = const Color.fromARGB(160, 0, 144, 138);
    MapPolyline routeMapPolyline;
    try {
      routeMapPolyline = MapPolyline.withRepresentation(
          routeGeoPolyline, MapPolylineSolidRepresentation(MapMeasureDependentRenderSize.withSingleSize(RenderSizeUnit.pixels, widthInPixels), polylineColor, LineCap.round));
      _hereMapController.mapScene.addMapPolyline(routeMapPolyline);
      _mapPolylines.add(routeMapPolyline);
    } on MapPolylineRepresentationInstantiationException catch (e) {
      logger.d("MapPolylineRepresentation Exception:${e.error.name}");
      return;
    } on MapMeasureDependentRenderSizeInstantiationException catch (e) {
      logger.d("MapMeasureDependentRenderSize Exception:${e.error.name}");
      return;
    }

    // Optionally, render traffic on route.
    _showTrafficOnRoute(route);
  }

  Color? _getTrafficColor(double? jamFactor) {
    if (jamFactor == null || jamFactor < 4) {
      return null;
    } else if (jamFactor >= 4 && jamFactor < 8) {
      return const Color.fromARGB(160, 255, 255, 0); // Yellow
    } else if (jamFactor >= 8 && jamFactor < 10) {
      return const Color.fromARGB(160, 255, 0, 0); // Red
    }
    return const Color.fromARGB(160, 0, 0, 0); // Black
  }

  _showTrafficOnRoute(rout.Route route) {
    if (route.lengthInMeters / 1000 > 5000) {
      logger.d("Skip showing traffic-on-route for longer routes.");
      return;
    }

    for (var section in route.sections) {
      for (var span in section.spans) {
        rout.TrafficSpeed trafficSpeed = span.trafficSpeed;
        Color? lineColor = _getTrafficColor(trafficSpeed.jamFactor);
        if (lineColor == null) {
          // We skip rendering low traffic.
          continue;
        }
        double widthInPixels = 10;
        MapPolyline trafficSpanMapPolyline;
        try {
          trafficSpanMapPolyline = MapPolyline.withRepresentation(
              span.geometry, MapPolylineSolidRepresentation(MapMeasureDependentRenderSize.withSingleSize(RenderSizeUnit.pixels, widthInPixels), lineColor, LineCap.round));
          _hereMapController.mapScene.addMapPolyline(trafficSpanMapPolyline);
          _mapPolylines.add(trafficSpanMapPolyline);
        } on MapPolylineRepresentationInstantiationException catch (e) {
          logger.d("MapPolylineRepresentation Exception:${e.error.name}");
          return;
        } on MapMeasureDependentRenderSizeInstantiationException catch (e) {
          logger.d("MapMeasureDependentRenderSize Exception:${e.error.name}");
          return;
        }
      }
    }
  }

  void _showRouteDetails(rout.Route route) {
    // estimatedTravelTimeInSeconds includes traffic delay.
    int estimatedTravelTimeInSeconds = route.duration.inSeconds;
    int estimatedTrafficDelayInSeconds = route.trafficDelay.inSeconds;
    int lengthInMeters = route.lengthInMeters;

    String routeDetails = 'Travel Time: ${_formatTime(estimatedTravelTimeInSeconds)}, Traffic Delay: ${_formatTime(estimatedTrafficDelayInSeconds)}, Length: ${_formatLength(lengthInMeters)}';

    _showDialog('Route Details', routeDetails);
    logger.d(routeDetails);
  }

  String _formatLength(int meters) {
    int kilometers = meters ~/ 1000;
    int remainingMeters = meters % 1000;

    return '$kilometers.$remainingMeters km';
  }

  String _formatTime(int sec) {
    int hours = sec ~/ 3600;
    int minutes = (sec % 3600) ~/ 60;

    return '$hours:$minutes min';
  }

  Future<void> _onMapCreated(HereMapController hereMapController) async {
    _hereMapController = hereMapController;
    _locationIndicator = LocationIndicator();
    loc.Location location = loc.Location();
    loc.LocationData locationData = await location.getLocation();

    final double latitude = locationData.latitude!;
    final double longitude = locationData.longitude!;

    //File mapStyle = File("assets/map_styles/custom-dark-style-neon-rds.json");
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalNight, (MapError? error) {
      // hereMapController.mapScene.loadSceneFromConfigurationFile(mapStyle.path, (MapError? error) {
      if (error != null) {
        logger.d('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 20000;
      MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      hereMapController.camera.lookAtPointWithMeasure(GeoCoordinates(latitude, longitude), mapMeasureZoom);
      hereMapController.mapScene.enableFeatures({MapFeatures.trafficFlow: MapFeatureModes.trafficFlowWithFreeFlow});
      hereMapController.mapScene.enableFeatures({MapFeatures.trafficIncidents: MapFeatureModes.defaultMode});
    });
    myLoc();
    for (RiderModel rider in riders) {
      addMarker(_hereMapController, rider.currentLatitude, rider.currentLongitude, "assets/images/rider.png");
    }
    for (var order in orders) {
      addMarker(_hereMapController, order.sourceLatitude, order.sourceLongitude, "assets/images/food.png");
      addMarker(_hereMapController, order.destinationLatitude, order.destinationLongitude, "assets/images/ecoeatspin.png");
      // waypoints.add(rout.Waypoint.withDefaults(GeoCoordinates(
      //     order.sourceLatitude, order.sourceLongitude)));
      waypoints.add(rout.Waypoint.withDefaults(GeoCoordinates(order.destinationLatitude, order.destinationLongitude)));
    }
  }

  void myLoc() {
    final locationData = context.read<LocationStore>().locationData;
    Location? myLocation = _locationEngine.lastKnownLocation;

    if (myLocation == null) {
      mylatit = locationData!.latitude!;
      mylongit = locationData.longitude!;
      // No last known location, use default instead.
      myLocation = Location.withCoordinates(GeoCoordinates(locationData.latitude!, locationData.longitude!));
      myLocation.time = DateTime.now();
    }

    // Set-up location indicator.
    // Enable a halo to indicate the horizontal accuracy.
    _locationIndicator.isAccuracyVisualized = true;
    _locationIndicator.locationIndicatorStyle = LocationIndicatorIndicatorStyle.pedestrian;
    _locationIndicator.updateLocation(myLocation);
    _locationIndicator.enable(_hereMapController);

    // MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, 2000);
    // _hereMapController!.camera.lookAtPointWithMeasure(
    //   myLocation.coordinates,
    //   mapMeasureZoom,
    // );

    // Update state's location.
    setState(() {
      //_location = myLocation;
    });
  }

  List allMarkers = [];

  void addMarker(HereMapController hereMapController, double lati, double longi, String logo) {
    logger.d("Add markers");
    int imageWidth = 100;
    int imageHeight = 100;
    MapImage mapImage = MapImage.withFilePathAndWidthAndHeight(logo, imageWidth, imageHeight);
    MapMarker mapMarker = MapMarker(GeoCoordinates(lati, longi), mapImage);
    allMarkers.add(mapMarker);
    _setTapGestureHandler();
    hereMapController.mapScene.addMapMarker(mapMarker);
  }

  void animateMarker(MapMarker marker, GeoCoordinates targetCoordinates, {required int durationMs}) {
    const stepDurationMs = 50;
    var steps = (durationMs / stepDurationMs).round();

    var latDiff = (targetCoordinates.latitude - marker.coordinates.latitude) / steps;
    var lonDiff = (targetCoordinates.longitude - marker.coordinates.longitude) / steps;

    var currentStep = 0;

    Timer.periodic(const Duration(milliseconds: stepDurationMs), (timer) {
      if (currentStep >= steps) {
        timer.cancel();
        return;
      }

      var newLat = marker.coordinates.latitude + latDiff;
      var newLon = marker.coordinates.longitude + lonDiff;

      marker.coordinates = GeoCoordinates(newLat, newLon);
      _hereMapController.mapScene.removeMapMarker(marker);
      _hereMapController.mapScene.addMapMarker(marker);

      currentStep++;
    });
  }

  void _setTapGestureHandler() {
    _hereMapController.gestures.tapListener = TapListener((Point2D touchPoint) {
      _pickMapMarker(touchPoint);
    });
  }

  void _pickMapMarker(Point2D touchPoint) {
    double radiusInPixel = 2;
    _hereMapController.pickMapItems(touchPoint, radiusInPixel, (pickMapItemsResult) {
      if (pickMapItemsResult == null) {
        // Pick operation failed.
        return;
      }

      // Note that MapMarker items contained in a cluster are not part of pickMapItemsResult.markers.
      //_handlePickedMapMarkerClusters(pickMapItemsResult);

      // Note that 3D map markers can't be picked yet. Only marker, polgon and polyline map items are pickable.
      List<MapMarker> mapMarkerList = pickMapItemsResult.markers;
      int listLength = mapMarkerList.length;
      if (listLength == 0) {
        logger.d("No map markers found.");
        return;
      }

      MapMarker topmostMapMarker = mapMarkerList.first;
      var coordinates = topmostMapMarker.coordinates;
      var selected;
      for (var order in orders) {
        if (order.sourceLatitude == coordinates.latitude && order.sourceLongitude == coordinates.longitude) {
          selected = order;
          break;
        }
      }
      _markerPopup(selected.sourceName, selected.name, selected.imageUrl, selected.quantity.toString(), selected.price.toString(), selected.status);
    });
  }

  Widget createWidget(String label, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.black),
      ),
      child: GestureDetector(
        child: Text(
          label,
          style: const TextStyle(fontSize: 20.0),
        ),
        onTap: () {
          logger.d("Tapped on $label");
        },
      ),
    );
  }
}
