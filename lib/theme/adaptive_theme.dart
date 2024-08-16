import 'package:flutter/material.dart';

class AdaptiveTheme {
  static ThemeData getTheme(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.deepOrange,
        secondary: Colors.orangeAccent,
      ),
      scaffoldBackgroundColor: Colors.grey[100], // Светлый фон для светлой темы
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.white, // Цвет фона для нижнего меню в светлой теме
      ),
      checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Colors.deepOrange),
      checkColor: WidgetStateProperty.all(Colors.orangeAccent),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: screenWidth * 0.08,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        displayMedium: TextStyle(
          fontSize: screenWidth * 0.07,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        displaySmall: TextStyle(
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        headlineLarge: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        headlineMedium: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        headlineSmall: TextStyle(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        titleLarge: TextStyle(
          fontSize: screenWidth * 0.035,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        titleMedium: TextStyle(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        titleSmall: TextStyle(
          fontSize: screenWidth * 0.025,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        bodyLarge: TextStyle(
          fontSize: screenWidth * 0.045,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        bodyMedium: TextStyle(
          fontSize: screenWidth * 0.04,
          color: Colors.black54,
          fontFamily: 'Roboto',
        ),
        bodySmall: TextStyle(
          fontSize: screenWidth * 0.035,
          color: Colors.black54,
          fontFamily: 'Roboto',
        ),
        labelLarge: TextStyle(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
        labelMedium: TextStyle(
          fontSize: screenWidth * 0.025,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          fontFamily: 'Roboto',
        ),
        labelSmall: TextStyle(
          fontSize: screenWidth * 0.02,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          fontFamily: 'Roboto',
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepOrange,
        titleTextStyle: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Установите цвет иконок для AppBar
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepOrange,
          textStyle: TextStyle(
            fontSize: screenWidth * 0.045,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      dividerColor: Colors.grey[300],
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
    progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.deepOrange, // Цвет для индикаторов загрузки
          circularTrackColor: Colors.deepOrange, // Цвет фона кругового индикатора
          linearTrackColor: Colors.deepOrange, // Цвет фона линейного индикатора
          // Вы можете также настроить другие параметры, если нужно
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
      scaffoldBackgroundColor: Colors.grey[850], // Темный фон для темной темы
      bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.grey[900], // Цвет фона для нижнего меню в темной теме
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: screenWidth * 0.08,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        displayMedium: TextStyle(
          fontSize: screenWidth * 0.07,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        displaySmall: TextStyle(
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        headlineLarge: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        headlineMedium: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        headlineSmall: TextStyle(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        titleLarge: TextStyle(
          fontSize: screenWidth * 0.035,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        titleMedium: TextStyle(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        titleSmall: TextStyle(
          fontSize: screenWidth * 0.025,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        bodyLarge: TextStyle(
          fontSize: screenWidth * 0.045,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        bodyMedium: TextStyle(
          fontSize: screenWidth * 0.04,
          color: Colors.white70,
          fontFamily: 'Roboto',
        ),
        bodySmall: TextStyle(
          fontSize: screenWidth * 0.035,
          color: Colors.white70,
          fontFamily: 'Roboto',
        ),
        labelLarge: TextStyle(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        labelMedium: TextStyle(
          fontSize: screenWidth * 0.025,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
          fontFamily: 'Roboto',
        ),
        labelSmall: TextStyle(
          fontSize: screenWidth * 0.02,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
          fontFamily: 'Roboto',
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepOrange,
        titleTextStyle: TextStyle(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Установите цвет иконок для AppBar
      ),
      dividerColor: Colors.grey[700],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepOrange,
          textStyle: TextStyle(
            fontSize: screenWidth * 0.045,
            fontFamily: 'Roboto',
          ),
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
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.deepOrange, // Цвет для индикаторов загрузки
          circularTrackColor: Colors.deepOrange, // Цвет фона кругового индикатора
          linearTrackColor: Colors.deepOrange, // Цвет фона линейного индикатора
          // Вы можете также настроить другие параметры, если нужно
        ),
    );
  }

  static ThemeData of(BuildContext context) {
    // Эта функция должна возвращать текущую тему, но её реализация не указана в вашем коде.
    return Theme.of(context);
  }
}
