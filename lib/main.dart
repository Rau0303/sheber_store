import 'package:firebase_app_check/firebase_app_check.dart';
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
await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
        // your preferred provider. Choose from:
        // 1. Debug provider
        // 2. Device Check provider
        // 3. App Attest provider
        // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
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
