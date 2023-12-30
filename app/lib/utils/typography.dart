import 'package:flutter/material.dart';

/// | NAME       | SIZE |  WEIGHT |  SPACING |             |
/// |------------|------|---------|----------|-------------|
/// | displayLarge  | 96.0 | light   | -1.5     |             |
/// | displayMedium  | 60.0 | light   | -0.5     |             |
/// | displaySmall  | 48.0 | regular |  0.0     |             |
/// | headlineLarge  | 40.0 | regular |  0.25    |             |
/// | headlineMedium  | 34.0 | regular |  0.25    |             |
/// | headlineSmall  | 24.0 | regular |  0.0     |             |
/// | titleLarge  | 20.0 | medium  |  0.15    |             |
/// | titleMedium  | 16.0 | regular |  0.15    |             |
/// | titleSmall  | 14.0 | medium  |  0.1     |             |
/// | bodyLarge      | 16.0 | regular |  0.5     | (bodyText1) |
/// | bodyMedium      | 14.0 | regular |  0.25    | (bodyText2) |
/// | bodySmall    | 12.0 | regular |  0.4     |             |
/// | labelLarge     | 14.0 | medium  |  1.25    |             |
/// | labelSmall   | 10.0 | regular |  1.5     |             |
///
/// ...where "light" is `FontWeight.w300`, "regular" is `FontWeight.w400` and
/// "medium" is `FontWeight.w500`.
///
class Typo {
  Typo._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: 96.0,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 60.0,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 34.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  );
}
