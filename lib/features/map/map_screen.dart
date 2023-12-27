import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:location/location.dart' as loc;

import '../../utils/palette.dart';
import 'CustomMapStyleExample.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // final HereMapController _hereMapController;
  // final MapCamera _mapCamera;
  CustomMapStyleExample? _customMapStyleExample;

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
              _customMapStyleExample?.loadCustomMapStyle();
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.search),
            onPressed: () {
              _customMapStyleExample?.loadCustomMapStyle();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onMapCreated(HereMapController hereMapController) async {
    loc.Location location = loc.Location();
    loc.LocationData locationData = await location.getLocation();

    final double latitude = locationData.latitude!;
    final double longitude = locationData.longitude!;

    File mapStyle = File("assets/map_styles/custom-dark-style-neon-rds.json");
    hereMapController.mapScene.loadSceneFromConfigurationFile(mapStyle.path, (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 50000;
      MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      hereMapController.camera.lookAtPointWithMeasure(GeoCoordinates(latitude, longitude), mapMeasureZoom);

      hereMapController.pinWidget(_createWidget("Centered ViewPin", Color.fromARGB(150, 0, 194, 138)), GeoCoordinates(19.0760, 72.8777));
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
