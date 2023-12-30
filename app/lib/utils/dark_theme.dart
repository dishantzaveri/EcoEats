import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';
import 'typography.dart';

ThemeData darkTheme() => ThemeData(
      primaryColor: Palette.primary,
      primarySwatch: Palette.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Palette.pureBlack,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Palette.primary,
        secondary: Palette.secondary,
      ),
      appBarTheme: const AppBarTheme(
        color: Palette.pureBlack,
        elevation: 0,
        iconTheme: IconThemeData(color: Palette.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Palette.pureBlack,
        selectedItemColor: Palette.primary,
        unselectedItemColor: Palette.white,
        selectedIconTheme: IconThemeData(color: Palette.primary),
        elevation: 0,
        
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
