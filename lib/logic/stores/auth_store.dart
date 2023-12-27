// Create a class AuthStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'package:flutter/material.dart';

class AuthStore extends ChangeNotifier {
  AuthStore._();

  static final AuthStore _instance = AuthStore._();

  factory AuthStore() {
    return _instance;
  }

  bool isAuthenticated = false;
}
