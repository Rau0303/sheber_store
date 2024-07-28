import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/app/sheber_market_app.dart';
import 'package:sheber_market/firebase_options.dart';
import 'package:sheber_market/providers/auth_provider.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen_logic.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen_logic.dart';
import 'package:sheber_market/screens/main/favorite_screen/favorites_screen_logic.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/profile_screen/profile_screen_logic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Добавьте другие провайдеры здесь, если нужно
      ],
      child: const SheberMarketApp(),
    ),
  );
}
