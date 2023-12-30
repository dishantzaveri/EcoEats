import 'package:logger/logger.dart';

import 'server_config.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 100, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
  // output: CustomLogOutput(),
);

final ServerDetail serverDetail = serverDetails['local']!;
final String apiUrl = serverDetail.baseUrl + serverDetail.apiPath;
