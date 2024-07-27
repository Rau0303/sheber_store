import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/app/sheber_market_app.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen_logic.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen_logic.dart';
import 'package:sheber_market/screens/main/favorite_screen/favorites_screen_logic.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/profile_screen/profile_screen_logic.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeScreenLogic()..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryScreenLogic(),
        ),
        ChangeNotifierProvider(
          create: (_) => BasketLogic(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesLogic(context),
        ),
        // В ProfileScreenLogic контекст может быть доступен позже
        ChangeNotifierProvider(
          create: (context) => ProfileScreenLogic(),
        ),
        // Добавьте другие провайдеры здесь, если нужно
      ],
      child: const SheberMarketApp(),
    ),
  );
}
