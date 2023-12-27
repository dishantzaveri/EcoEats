// Create a class LocationStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:here_hackathon/utils/const.dart';
import 'package:location/location.dart' as loc;

class LocationStore extends ChangeNotifier {
  LocationStore._();

  static final LocationStore _instance = LocationStore._();

  factory LocationStore() {
    return _instance;
  }

  loc.Location locationObject = loc.Location();
  loc.LocationData? locationData;

  Future<void> initLocation() async {
    logger.d("initLocation");

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await locationObject.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationObject.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationObject.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await locationObject.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    locationData = await locationObject.getLocation();

    notifyListeners();
    // run refresh connection every 30 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      refreshLocation();
    });
  }

  Future<void> refreshLocation() async {
    logger.d("refreshLocation");
    locationData = await locationObject.getLocation();
    notifyListeners();
  }

  Future<void> updateLocation() async {
    locationData = await locationObject.getLocation();
    notifyListeners();
  }
}
