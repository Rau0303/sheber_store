import 'package:flutter/material.dart';
import 'package:sheber_market/app/sheber_market_app.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen_logic.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen_logic.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeScreenLogic()..init(), // Инициализируйте HomeScreenLogic
        ),
        ChangeNotifierProvider(
          create: (_) =>CategoryScreenLogic()),
        // Добавьте другие провайдеры здесь, если нужно
      ],
      child: const SheberMarketApp(),
    ),
  );
}

