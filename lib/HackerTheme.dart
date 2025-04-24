

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
ThemeData getHackerTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    dialogBackgroundColor: Colors.black,

    colorScheme: ColorScheme.dark(
      primary: Color(0xFF39FF14), // Neon green
      secondary: Color(0xFFFFA500), // Neon orange
      error: Color(0xFFFF5E00),
      background: Colors.black,
      surface: Colors.grey[900]!, // Slight contrast for surfaces
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onError: Colors.black,
      onBackground: Color(0xFF39FF14),
      onSurface: Color(0xFF39FF14),
    ),

    textTheme: GoogleFonts.turretRoadTextTheme(
      const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF39FF14)),
        bodyMedium: TextStyle(color: Color(0xFF39FF14)),
        titleLarge: TextStyle(color: Color(0xFF39FF14)),
        titleMedium: TextStyle(color: Color(0xFF39FF14)),
        headlineMedium: TextStyle(color: Color(0xFF39FF14)),
        labelLarge: TextStyle(color: Color(0xFF39FF14)),
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Color(0xFF39FF14),
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[850], // Dark button background
        foregroundColor: Color(0xFF39FF14), // Neon green text
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.grey[850], // Same dark contrast
        foregroundColor: Color(0xFF39FF14),
        side: const BorderSide(color: Color(0xFF39FF14)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1A1A1A), // Darker gray input background
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Color(0xFF39FF14)),
      errorStyle: TextStyle(color: Color(0xFFFF5E00)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF39FF14)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF39FF14), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFF5E00)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFF5E00), width: 2),
      ),
    ),
  );
}
