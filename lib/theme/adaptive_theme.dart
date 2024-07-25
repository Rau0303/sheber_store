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
        // Используется для очень больших заголовков, например, на страницах приветствия
        displayLarge: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для больших заголовков, например, на страницах с важной информацией
        displayMedium: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для меньших заголовков, например, в карточках или виджетах
        displaySmall: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для заголовков на страницах, например, заголовок статьи или секции
        headlineLarge: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для подзаголовков, например, в секциях или блоках текста
        headlineMedium: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для еще меньших подзаголовков, например, внутри карточек
        headlineSmall: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для крупных заголовков в виджетах, например, заголовок формы
        titleLarge: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для средних заголовков в виджетах, например, заголовок секции
        titleMedium: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для небольших заголовков, например, заголовок маленькой карточки
        titleSmall: TextStyle(fontSize: screenWidth * 0.025, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для основного текста, например, в статьях или параграфах
        bodyLarge: TextStyle(fontSize: screenWidth * 0.045, color: Colors.black),
        // Используется для основного текста среднего размера, например, в описаниях или примечаниях
        bodyMedium: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
        // Используется для меньшего основного текста, например, в подсказках или второстепенных блоках текста
        bodySmall: TextStyle(fontSize: screenWidth * 0.035, color: Colors.black54),
        // Используется для крупных меток, например, в кнопках или иконках
        labelLarge: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold, color: Colors.black),
        // Используется для средних меток, например, в формах или значках
        labelMedium: TextStyle(fontSize: screenWidth * 0.025, fontWeight: FontWeight.bold, color: Colors.black54),
        // Используется для небольших меток, например, в маленьких кнопках или значках
        labelSmall: TextStyle(fontSize: screenWidth * 0.02, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepOrange,
        titleTextStyle: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.deepOrange,
          textStyle: TextStyle(fontSize: screenWidth * 0.045),
        ),
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
        // Используется для очень больших заголовков, например, на страницах приветствия
        displayLarge: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для больших заголовков, например, на страницах с важной информацией
        displayMedium: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для меньших заголовков, например, в карточках или виджетах
        displaySmall: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для заголовков на страницах, например, заголовок статьи или секции
        headlineLarge: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для подзаголовков, например, в секциях или блоках текста
        headlineMedium: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для еще меньших подзаголовков, например, внутри карточек
        headlineSmall: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для крупных заголовков в виджетах, например, заголовок формы
        titleLarge: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для средних заголовков в виджетах, например, заголовок секции
        titleMedium: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для небольших заголовков, например, заголовок маленькой карточки
        titleSmall: TextStyle(fontSize: screenWidth * 0.025, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для основного текста, например, в статьях или параграфах
        bodyLarge: TextStyle(fontSize: screenWidth * 0.045, color: Colors.white),
        // Используется для основного текста среднего размера, например, в описаниях или примечаниях
        bodyMedium: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white70),
        // Используется для меньшего основного текста, например, в подсказках или второстепенных блоках текста
        bodySmall: TextStyle(fontSize: screenWidth * 0.035, color: Colors.white70),
        // Используется для крупных меток, например, в кнопках или иконках
        labelLarge: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold, color: Colors.white),
        // Используется для средних меток, например, в формах или значках
        labelMedium: TextStyle(fontSize: screenWidth * 0.025, fontWeight: FontWeight.bold, color: Colors.white70),
        // Используется для небольших меток, например, в маленьких кнопках или значках
        labelSmall: TextStyle(fontSize: screenWidth * 0.02, fontWeight: FontWeight.bold, color: Colors.white70),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepOrange,
        titleTextStyle: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.deepOrange,
          textStyle: TextStyle(fontSize: screenWidth * 0.045),
        ),
      ),
    );
  }
}
