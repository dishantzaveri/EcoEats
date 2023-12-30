// ignore_for_file: avoid_print

import 'package:logger/logger.dart';

class CustomLogOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      switch (event.level) {
        case Level.info:
          print(line); // Blue color for info
          // print('\x1B[34m$line\x1B[0m'); // Blue color for info
          break;
        // Define other cases for different log levels if needed
        case Level.error:
          print('!!!!!!!!!!$line'); // Green color for debug
          break;
        default:
          print(line); // Default print for other log levels
          break;
      }
    }
  }
}
