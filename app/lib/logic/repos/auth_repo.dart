// Create a class AuthRepo that uses singleton pattern.

import 'package:dio/dio.dart';

class AuthRepo {
  static AuthRepo? _instance;

  AuthRepo._();

  static AuthRepo get instance {
    _instance ??= AuthRepo._();
    return _instance!;
  }

  final Dio client = Dio();
}
