// Create a class OrderRepo that uses singleton pattern.

import 'package:dio/dio.dart';

class OrderRepo {
  static OrderRepo? _instance;

  OrderRepo._();

  static OrderRepo get instance {
    _instance ??= OrderRepo._();
    return _instance!;
  }

  final Dio client = Dio();
}
