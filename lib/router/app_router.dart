import 'package:flutter/material.dart';
import 'package:sheber_market/screens/auth/login_screen/login_screen.dart';
import 'package:sheber_market/screens/auth/sms_verifivation_screen/sms_verification_screen.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen.dart';
import 'package:sheber_market/screens/main/main_screen/main_screen.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen.dart'; // Импортируйте BasketScreen
import 'package:sheber_market/screens/main/favorite_screen/favorites_screen.dart'; // Импортируйте FavoritesScreen

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/sms_verification':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SmsVerificationScreen(
            verificationId: args['verificationId'] as String,
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/main':
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      case '/categories':
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(),
        );
      case '/basket':
        return MaterialPageRoute(
          builder: (_) => const BasketScreen(),
        );
      case '/favorites': // Добавьте маршрут для FavoritesScreen
        return MaterialPageRoute(
          builder: (_) => const FavoritesScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
