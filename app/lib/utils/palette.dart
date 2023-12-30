import 'package:flutter/material.dart';

class Palette {
  // Create a MaterialColor Swatch for Primary Color
  static const MaterialColor primary = MaterialColor(
    0xFF8224E0,
    <int, Color>{
      50: Color(0xFF8224E0),
      100: Color(0xFF8224E0),
      200: Color(0xFF8224E0),
      300: Color(0xFF8224E0),
      400: Color(0xFF8224E0),
      500: Color(0xFF8224E0),
      600: Color(0xFF8224E0),
      700: Color(0xFF8224E0),
      800: Color(0xFF8224E0),
      900: Color(0xFF8224E0),
    },
  );

  // Create a MaterialColor Swatch for Secondary Color
  static const MaterialColor secondary = MaterialColor(
    0xFF533FCC,
    <int, Color>{
      50: Color(0xFF533FCC),
      100: Color(0xFF533FCC),
      200: Color(0xFF533FCC),
      300: Color(0xFF533FCC),
      400: Color(0xFF533FCC),
      500: Color(0xFF533FCC),
      600: Color(0xFF533FCC),
      700: Color(0xFF533FCC),
      800: Color(0xFF533FCC),
      900: Color(0xFF533FCC),
    },
  );

  static const Color pureBlack = Color(0xFF000000);
  static const Color black = Color(0xFF1F1F1F);
  static const Color dark = Color(0xFF626262);
  static const Color grey = Color(0xFF8F8F8F);
  static const Color light = Color(0xFFD2D2D2);
  static const Color white = Color(0xFFF4F4F4);
  static const Color pureWhite = Color(0xFFFFFFFF);
}
