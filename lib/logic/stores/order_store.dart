// Create a class OrderStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'package:flutter/material.dart';

class OrderStore extends ChangeNotifier {
  OrderStore._();

  static final OrderStore _instance = OrderStore._();

  factory OrderStore() {
    return _instance;
  }
}
