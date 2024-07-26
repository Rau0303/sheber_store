import 'package:flutter/material.dart';

class AdaptiveTheme {
  static ThemeData getTheme(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.white,
        secondary: Colors.deepOrange,
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold, color: Colors.black),
        displayMedium: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold, color: Colors.black),
        displaySmall: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Colors.black),
        headlineLarge: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.black),
        headlineMedium: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.black),
        headlineSmall: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold, color: Colors.black),
        titleSmall: TextStyle(fontSize: screenWidth * 0.025, fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: TextStyle(fontSize: screenWidth * 0.045, color: Colors.black),
        bodyMedium: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
        bodySmall: TextStyle(fontSize: screenWidth * 0.035, color: Colors.black54),
        labelLarge: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold, color: Colors.black),
        labelMedium: TextStyle(fontSize: screenWidth * 0.025, fontWeight: FontWeight.bold, color: Colors.black54),
        labelSmall: TextStyle(fontSize: screenWidth * 0.02, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepOrange,
        titleTextStyle: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepOrange,
          textStyle: TextStyle(fontSize: screenWidth * 0.045),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.deepOrange),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.deepOrange),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade500),
        labelStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.red),
        fillColor: Colors.transparent,
        filled: false,
      ),
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Colors.black,
        secondary: Colors.deepOrange,
      ),
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold, color: Colors.white),
        displaySmall: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Colors.white),
        headlineLarge: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.white),
        headlineSmall: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold, color: Colors.white),
        titleSmall: TextStyle(fontSize: screenWidth * 0.025, fontWeight: FontWeight.bold, color: Colors.white),
        bodyLarge: TextStyle(fontSize: screenWidth * 0.045, color: Colors.white),
        bodyMedium: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white70),
        bodySmall: TextStyle(fontSize: screenWidth * 0.035, color: Colors.white70),
        labelLarge: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold, color: Colors.white),
        labelMedium: TextStyle(fontSize: screenWidth * 0.025, fontWeight: FontWeight.bold, color: Colors.white70),
        labelSmall: TextStyle(fontSize: screenWidth * 0.02, fontWeight: FontWeight.bold, color: Colors.white70),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepOrange,
        titleTextStyle: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepOrange,
          textStyle: TextStyle(fontSize: screenWidth * 0.045),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        labelStyle: const TextStyle(color: Colors.white),
        errorStyle: const TextStyle(color: Colors.red),
        fillColor: Colors.transparent,
        filled: false,
      ),
    );
  }

  static ThemeData of(BuildContext context) {
    // Эта функция должна возвращать текущую тему, но её реализация не указана в вашем коде.
    return Theme.of(context);
  }
}
