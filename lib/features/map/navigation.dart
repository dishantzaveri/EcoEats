/*
 * Copyright (C) 2019-2023 here Europe B.V.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 * License-Filename: LICENSE
 */

import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart' as here;
import 'package:here_sdk/core.engine.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/navigation.dart' as here;
import 'package:here_sdk/routing.dart' as here;

import '../../utils/const.dart';

void main() {
  // Usually, you need to initialize the here SDK only once during the lifetime of an application.
  _initializehereSDK();

  // Ensure that all widgets, including MyApp, have a MaterialLocalizations object available.
  runApp(const MaterialApp(home: MyApp()));
}

void _initializehereSDK() async {
  // Needs to be called before accessing SDKOptions to load necessary libraries.
  here.SdkContext.init(here.IsolateOrigin.main);

  // Set your credentials for the here SDK.
  String accessKeyId = "YOUR_ACCESS_KEY_ID";
  String accessKeySecret = "YOUR_ACCESS_KEY_SECRET";
  SDKOptions sdkOptions = SDKOptions.withAccessKeySecret(accessKeyId, accessKeySecret);

  try {
    await SDKNativeEngine.makeSharedInstance(sdkOptions);
  } on InstantiationException {
    throw Exception("Failed to initialize the here SDK.");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  HereMapController? _hereMapController;

  here.RoutingEngine? _routingEngine;
  here.VisualNavigator? _visualNavigator;
  here.LocationSimulator? _locationSimulator;

  Future<bool> _handleBackPress() async {
    // Handle the back press.
    _visualNavigator?.stopRendering();
    _locationSimulator?.stop();

    // Return true to allow the back press.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPress,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Navigation QS Example'),
        ),
        body: Stack(
          children: [
            HereMap(onMapCreated: _onMapCreated),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    _hereMapController = hereMapController;
    _hereMapController!.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) {
      if (error != null) {
        logger.d('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 8000;
      MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      _hereMapController!.camera.lookAtPointWithMeasure(here.GeoCoordinates(52.520798, 13.409408), mapMeasureZoom);

      _startGuidanceExample();
    });
  }

  _startGuidanceExample() {
    _showDialog("Navigation Quick Start", "This app routes to the here office in Berlin. See logs for guidance information.");

    // We start by calculating a car route.
    _calculateRoute();
  }

  _calculateRoute() {
    try {
      _routingEngine = here.RoutingEngine();
    } on InstantiationException {
      throw Exception('Initialization of RoutingEngine failed.');
    }

    here.Waypoint startWaypoint = here.Waypoint(here.GeoCoordinates(52.520798, 13.409408));
    here.Waypoint destinationWaypoint = here.Waypoint(here.GeoCoordinates(52.530905, 13.385007));

    _routingEngine!.calculateCarRoute([startWaypoint, destinationWaypoint], here.CarOptions(), (here.RoutingError? routingError, List<here.Route>? routeList) async {
      if (routingError == null) {
        // When error is null, it is guaranteed that the routeList is not empty.
        here.Route calculatedRoute = routeList!.first;
        _startGuidance(calculatedRoute);
      } else {
        final error = routingError.toString();
        logger.d('Error while calculating a route: $error');
      }
    });
  }

  _startGuidance(here.Route route) {
    try {
      // Without a route set, this starts tracking mode.
      _visualNavigator = here.VisualNavigator();
    } on InstantiationException {
      throw Exception("Initialization of VisualNavigator failed.");
    }

    // This enables a navigation view including a rendered navigation arrow.
    _visualNavigator!.startRendering(_hereMapController!);

    // Hook in one of the many listeners. here we set up a listener to get instructions on the maneuvers to take while driving.
    // For more details, please check the "navigation_app" example and the Developer's Guide.
    _visualNavigator!.maneuverNotificationListener = here.ManeuverNotificationListener((String maneuverText) {
      logger.d("ManeuverNotifications: $maneuverText");
    });

    // Set a route to follow. This leaves tracking mode.
    _visualNavigator!.route = route;

    // VisualNavigator acts as LocationListener to receive location updates directly from a location provider.
    // Any progress along the route is a result of getting a new location fed into the VisualNavigator.
    _setupLocationSource(_visualNavigator!, route);
  }

  _setupLocationSource(here.LocationListener locationListener, here.Route route) {
    try {
      // Provides fake GPS signals based on the route geometry.
      _locationSimulator = here.LocationSimulator.withRoute(route, here.LocationSimulatorOptions());
    } on InstantiationException {
      throw Exception("Initialization of LocationSimulator failed.");
    }

    _locationSimulator!.listener = locationListener;
    _locationSimulator!.start();
  }

  @override
  void dispose() {
    // Free here SDK resources before the application shuts down.
    SDKNativeEngine.sharedInstance?.dispose();
    here.SdkContext.release();
    super.dispose();
  }

  // A helper method to show a dialog.
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
}
