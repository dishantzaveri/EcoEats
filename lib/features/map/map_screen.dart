import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:here_hackathon/logic/stores/order_store.dart';
import 'package:here_hackathon/utils/const.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/gestures.dart';
import 'package:here_sdk/location.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/navigation.dart' as nav;
import 'package:here_sdk/routing.dart' as rout;
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';
import 'package:here_sdk/animation.dart' as anim;

import '../../logic/stores/location_store.dart';
import '../../utils/palette.dart';
import 'CustomMapStyleExample.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

enum TtsState { playing, stopped, paused, continued }

class _MapScreenState extends State<MapScreen> {
  late final HereMapController _hereMapController;
  // final MapCamera _mapCamera;
  CustomMapStyleExample? _customMapStyleExample;
  late LocationEngine _locationEngine;
  late LocationIndicator _locationIndicator;
  late rout.RoutingEngine _routingEngine;
  late double latit, longit;
  late double mylongit, mylatit;
  List<MapPolyline> _mapPolylines = [];
  nav.VisualNavigator? _visualNavigator;
  nav.LocationSimulator? _locationSimulator;
  late rout.Route route;
  bool isNavigating = false;
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;

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
    logger.d(context.read<OrderStore>().riders);
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
          child: const Icon(Icons.add),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Palette.secondary,
          backgroundColor: Palette.primary,
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
              latit = mylatit + Random().nextDouble() * 0.1 - 0.005;
              longit = mylongit + Random().nextDouble() * 0.1 - 0.005;
              addMarker(_hereMapController, latit, longit,
                  "assets/images/ecoeatspin.png");
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
              isNavigating
                  ? _visualNavigator!.stopRendering()
                  : _startGuidance(route);
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
    _visualNavigator!.startRendering(_hereMapController!);

    // Hook in one of the many listeners. Here we set up a listener to get instructions on the maneuvers to take while driving.
    // For more details, please check the "navigation_app" example and the Developer's Guide.
    _visualNavigator!.maneuverNotificationListener =
        nav.ManeuverNotificationListener((String maneuverText) async {
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
      _locationSimulator = nav.LocationSimulator.withRoute(
          route, nav.LocationSimulatorOptions());
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
    Size2D sizeInPixels = Size2D(_hereMapController.viewportSize.width - 100,
        _hereMapController.viewportSize.height - 100);
    Rectangle2D mapViewport = Rectangle2D(origin, sizeInPixels);

    // Animate to the route within a duration of 3 seconds.
    MapCameraUpdate update =
        MapCameraUpdateFactory.lookAtAreaWithGeoOrientationAndViewRectangle(
            route!.boundingBox,
            GeoOrientationUpdate(bearing, tilt),
            mapViewport);
    MapCameraAnimation animation =
        MapCameraAnimationFactory.createAnimationFromUpdateWithEasing(
            update,
            const Duration(milliseconds: 3000),
            anim.Easing(anim.EasingFunction.inCubic));
    _hereMapController.camera.startAnimation(animation);
  }

  GeoCoordinates _createRandomGeoCoordinatesInViewport() {
    GeoBox? geoBox = _hereMapController.camera.boundingBox;
    if (geoBox == null) {
      // Happens only when map is not fully covering the viewport as the map is tilted.
      print(
          "The map view is tilted, falling back to fixed destination coordinate.");
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
  List options = [
    rout.CarOptions,
    rout.TruckOptions,
    rout.PedestrianOptions,
    rout.ScooterOptions,
    rout.BicycleOptions,
    rout.EVCarOptions,
    rout.TaxiOptions,
    rout.BusOptions,
    rout.TaxiOptions
  ];
  Future<void> addRoute() async {
    logger.d("Calculating ${options[i]} route.");
    var startGeoCoordinates = GeoCoordinates(mylatit, mylongit);
    var destinationGeoCoordinates = GeoCoordinates(latit, longit);
    logger.d("$mylatit + $mylongit + $latit + $longit");
    var startWaypoint = rout.Waypoint.withDefaults(startGeoCoordinates);
    var destinationWaypoint =
        rout.Waypoint.withDefaults(destinationGeoCoordinates);

    var w1 = _createRandomGeoCoordinatesInViewport();
    addMarker(_hereMapController, w1.latitude, w1.longitude,
        "assets/images/ecoeatspin.png");
    var waypoint1 = rout.Waypoint.withDefaults(w1);
    var w2 = _createRandomGeoCoordinatesInViewport();
    addMarker(_hereMapController, w2.latitude, w2.longitude,
        "assets/images/ecoeatspin.png");
    var waypoint2 = rout.Waypoint.withDefaults(w2);

    List<rout.Waypoint> initailPoints = [
      startWaypoint,
      // waypoint1,
      // waypoint2,
      destinationWaypoint
    ];

    List<rout.Waypoint> waypoints = [waypoint1, waypoint2, destinationWaypoint];
    List<rout.Waypoint> selectedWaypoints = [startWaypoint];

    _routingEngine.calculateCarRoute(initailPoints, rout.CarOptions(),
        (rout.RoutingError? routingError,
            List<rout.Route>? initialRouteList) async {
      if (routingError == null) {
        rout.Route initialRoute = initialRouteList!.first;
        double initialDistance = initialRoute.lengthInMeters.toDouble();
        for (var waypoint in waypoints) {
          var candidateWaypoints = [
            ...selectedWaypoints,
            waypoint,
            destinationWaypoint
          ];
          _routingEngine
              .calculateCarRoute(candidateWaypoints, rout.CarOptions(),
                  (rout.RoutingError? routingError,
                      List<rout.Route>? routeList) async {
            if (routingError == null) {
              rout.Route candidateRoute = routeList!.first;
              double candidateDistance =
                  candidateRoute.lengthInMeters.toDouble();

              // Check if adding the waypoint increases the route length by a certain threshold (e.g., 10%).
              double threshold = 1.5;
              if (candidateDistance < initialDistance * threshold) {
                // Include the waypoint in the selected waypoints list.
                selectedWaypoints.add(waypoint);

                // Update the map and visualization as needed.
                _animateToRoute(candidateRoute);
                _showRouteDetails(candidateRoute);
                _showRouteOnMap(candidateRoute);
                _logRouteViolations(candidateRoute);
                setState(() {
                  route = candidateRoute;
                });
                //_startGuidance(candidateRoute);
              }
            }
          });
        }
        // rout.Route route = routeList!.first;
        // _animateToRoute(route);
        // _showRouteDetails(route);
        // _showRouteOnMap(route);
        // _logRouteViolations(route);
        // _startGuidance(route);
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
              child: Text('OK'),
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
        logger.d("This route contains the following warning: " +
            notice.code.toString());
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
          routeGeoPolyline,
          MapPolylineSolidRepresentation(
              MapMeasureDependentRenderSize.withSingleSize(
                  RenderSizeUnit.pixels, widthInPixels),
              polylineColor,
              LineCap.round));
      _hereMapController.mapScene.addMapPolyline(routeMapPolyline);
      _mapPolylines.add(routeMapPolyline);
    } on MapPolylineRepresentationInstantiationException catch (e) {
      print("MapPolylineRepresentation Exception:" + e.error.name);
      return;
    } on MapMeasureDependentRenderSizeInstantiationException catch (e) {
      print("MapMeasureDependentRenderSize Exception:" + e.error.name);
      return;
    }

    // Optionally, render traffic on route.
    _showTrafficOnRoute(route);
  }

  Color? _getTrafficColor(double? jamFactor) {
    if (jamFactor == null || jamFactor < 4) {
      return null;
    } else if (jamFactor >= 4 && jamFactor < 8) {
      return Color.fromARGB(160, 255, 255, 0); // Yellow
    } else if (jamFactor >= 8 && jamFactor < 10) {
      return Color.fromARGB(160, 255, 0, 0); // Red
    }
    return Color.fromARGB(160, 0, 0, 0); // Black
  }

  _showTrafficOnRoute(rout.Route route) {
    if (route.lengthInMeters / 1000 > 5000) {
      print("Skip showing traffic-on-route for longer routes.");
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
          trafficSpanMapPolyline = new MapPolyline.withRepresentation(
              span.geometry,
              MapPolylineSolidRepresentation(
                  MapMeasureDependentRenderSize.withSingleSize(
                      RenderSizeUnit.pixels, widthInPixels),
                  lineColor,
                  LineCap.round));
          _hereMapController.mapScene.addMapPolyline(trafficSpanMapPolyline);
          _mapPolylines.add(trafficSpanMapPolyline);
        } on MapPolylineRepresentationInstantiationException catch (e) {
          print("MapPolylineRepresentation Exception:" + e.error.name);
          return;
        } on MapMeasureDependentRenderSizeInstantiationException catch (e) {
          print("MapMeasureDependentRenderSize Exception:" + e.error.name);
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

    String routeDetails = 'Travel Time: ' +
        _formatTime(estimatedTravelTimeInSeconds) +
        ', Traffic Delay: ' +
        _formatTime(estimatedTrafficDelayInSeconds) +
        ', Length: ' +
        _formatLength(lengthInMeters);

    _showDialog('Route Details', '$routeDetails');
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
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalNight,
        (MapError? error) {
      // hereMapController.mapScene.loadSceneFromConfigurationFile(mapStyle.path, (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 20000;
      MapMeasure mapMeasureZoom =
          MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      hereMapController.camera.lookAtPointWithMeasure(
          GeoCoordinates(latitude, longitude), mapMeasureZoom);
      // hereMapController.mapScene.enableFeatures(
      //     {MapFeatures.trafficFlow: MapFeatureModes.trafficFlowWithFreeFlow});
      hereMapController.mapScene.enableFeatures(
          {MapFeatures.trafficIncidents: MapFeatureModes.defaultMode});
    });
    myLoc();
  }

  void myLoc() {
    final locationData = context.read<LocationStore>().locationData;
    Location? myLocation = _locationEngine.lastKnownLocation;

    if (myLocation == null) {
      mylatit = locationData!.latitude!;
      mylongit = locationData.longitude!;
      // No last known location, use default instead.
      myLocation = Location.withCoordinates(
          GeoCoordinates(locationData!.latitude!, locationData.longitude!));
      myLocation.time = DateTime.now();
    }

    // Set-up location indicator.
    // Enable a halo to indicate the horizontal accuracy.
    _locationIndicator!.isAccuracyVisualized = true;
    _locationIndicator!.locationIndicatorStyle =
        LocationIndicatorIndicatorStyle.pedestrian;
    _locationIndicator!.updateLocation(myLocation);
    _locationIndicator!.enable(_hereMapController!);

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

  void addMarker(HereMapController hereMapController, double lati, double longi,
      String logo) {
    logger.d("Add markers");
    int imageWidth = 100;
    int imageHeight = 100;
    MapImage mapImage =
        MapImage.withFilePathAndWidthAndHeight(logo, imageWidth, imageHeight);
    MapMarker mapMarker = MapMarker(GeoCoordinates(lati, longi), mapImage);
    _setTapGestureHandler();
    hereMapController.mapScene.addMapMarker(mapMarker);
  }

  void _setTapGestureHandler() {
    _hereMapController.gestures.tapListener = TapListener((Point2D touchPoint) {
      _pickMapMarker(touchPoint);
    });
  }

  void _pickMapMarker(Point2D touchPoint) {
    double radiusInPixel = 2;
    _hereMapController.pickMapItems(touchPoint, radiusInPixel,
        (pickMapItemsResult) {
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
        print("No map markers found.");
        return;
      }

      MapMarker topmostMapMarker = mapMarkerList.first;
      Metadata? metadata = topmostMapMarker.metadata;
      if (metadata != null) {
        String message = metadata.getString("key_poi") ?? "No message found.";

        _showDialog("Map Marker picked", message);
        return;
      }

      _showDialog("Map Marker picked", "No metadata attached.");
    });
  }

  Widget _createWidget(String label, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.black),
      ),
      child: GestureDetector(
        child: Text(
          label,
          style: TextStyle(fontSize: 20.0),
        ),
        onTap: () {
          print("Tapped on " + label);
        },
      ),
    );
  }
}
