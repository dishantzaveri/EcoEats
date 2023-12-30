import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';
import 'typography.dart';

ThemeData lightTheme() => ThemeData(
      primaryColor: Palette.primary,
      primarySwatch: Palette.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Palette.white,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Palette.primary,
        secondary: Palette.secondary,
      ),
      appBarTheme: const AppBarTheme(
        color: Palette.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Palette.black),
      ),
      fontFamily: GoogleFonts.montserrat().fontFamily,
      textTheme: const TextTheme(
        displayLarge: Typo.displayLarge,
        displayMedium: Typo.displayMedium,
        displaySmall: Typo.displaySmall,
        headlineLarge: Typo.headlineLarge,
        headlineMedium: Typo.headlineMedium,
        headlineSmall: Typo.headlineSmall,
        titleLarge: Typo.titleLarge,
        titleMedium: Typo.titleMedium,
        titleSmall: Typo.titleSmall,
        bodyLarge: Typo.bodyLarge,
        bodyMedium: Typo.bodyMedium,
        bodySmall: Typo.bodySmall,
        labelLarge: Typo.labelLarge,
        labelSmall: Typo.labelSmall,
      ),
    );
