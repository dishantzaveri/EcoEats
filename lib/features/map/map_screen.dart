import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:here_hackathon/utils/const.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/location.dart';
import 'package:here_sdk/mapview.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';

import '../../logic/stores/location_store.dart';
import '../../utils/palette.dart';
import 'CustomMapStyleExample.dart';
import 'RoutingExample.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final HereMapController _hereMapController;
  // final MapCamera _mapCamera;
  CustomMapStyleExample? _customMapStyleExample;
  late LocationEngine _locationEngine;
  late LocationIndicator _locationIndicator;
  RoutingExample? _routingExample;

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
              addMarker(_hereMapController, 19.0760 + Random().nextDouble() * 0.1 - 0.005, 72.8777 + Random().nextDouble() * 0.1 - 0.005, "assets/images/ecoeats.png");
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.location_pin),
            onPressed: () {
              myLoc(19.0760, 72.8777);
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.route),
            onPressed: () {
              _routingExample?.addRoute();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onMapCreated(HereMapController hereMapController) async {
    try {
      _locationEngine = LocationEngine();
    } on InstantiationException {
      throw ("Initialization of LocationEngine failed.");
    }
    _hereMapController = hereMapController;
    _locationIndicator = LocationIndicator();
    loc.Location location = loc.Location();
    loc.LocationData locationData = await location.getLocation();

    final double latitude = locationData.latitude!;
    final double longitude = locationData.longitude!;

    //File mapStyle = File("assets/map_styles/custom-dark-style-neon-rds.json");
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) {
      // hereMapController.mapScene.loadSceneFromConfigurationFile(mapStyle.path, (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 20000;
      MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      hereMapController.camera.lookAtPointWithMeasure(GeoCoordinates(latitude, longitude), mapMeasureZoom);
    });
  }

  void myLoc(double lati, double longi) {
    final locationData = context.read<LocationStore>().locationData;
    Location? myLocation = _locationEngine.lastKnownLocation;

    if (myLocation == null) {
      // No last known location, use default instead.
      myLocation = Location.withCoordinates(GeoCoordinates(locationData!.latitude!, locationData.longitude!));
      myLocation.time = DateTime.now();
    }

    // Set-up location indicator.
    // Enable a halo to indicate the horizontal accuracy.
    _locationIndicator!.isAccuracyVisualized = true;
    _locationIndicator!.locationIndicatorStyle = LocationIndicatorIndicatorStyle.pedestrian;
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

  void addMarker(HereMapController hereMapController, double lati, double longi, String logo) {
    logger.d("Add markers");
    int imageWidth = 300;
    int imageHeight = 300;
    MapImage mapImage = MapImage.withFilePathAndWidthAndHeight(logo, imageWidth, imageHeight);
    MapMarker mapMarker = MapMarker(GeoCoordinates(lati, longi), mapImage);
    hereMapController.mapScene.addMapMarker(mapMarker);
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
