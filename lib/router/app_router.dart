import 'package:flutter/material.dart';
import 'package:sheber_market/screens/auth/login_screen/login_screen.dart';
import 'package:sheber_market/screens/auth/sms_verifivation_screen/sms_verification_screen.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen.dart';
import 'package:sheber_market/screens/main/main_screen/main_screen.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen.dart';
import 'package:sheber_market/screens/main/favorite_screen/favorites_screen.dart';
import 'package:sheber_market/screens/main/product_screen/product_screen.dart';
import 'package:sheber_market/screens/main/product_screen/product_inform_screen/product_inform_screen.dart'; // Импортируйте ProductInformScreen
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/address_screen/address_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/profile_settings_screen/profile_settings_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/profile_screen.dart';
import 'package:sheber_market/models/product.dart'; // Импортируйте модель Product

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
      case '/favorites':
        return MaterialPageRoute(
          builder: (_) => const FavoritesScreen(),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case '/products':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProductScreen(category: args['category'] as String),
        );
      case '/product_inform':
        final args = settings.arguments as Map<String, dynamic>;
        final product = args['product'] as Product;
        return MaterialPageRoute(
          builder: (_) => ProductInformScreen(product: product),
        );
      // В файле AppRouter
      case '/address-settings':
         return MaterialPageRoute(
            builder: (_) => const AddressScreen(),
        );
      case '/payment-cards':
         return MaterialPageRoute(
            builder: (_) => const PaymentCardsScreen(),
        );
      case '/profile-settings':
         return MaterialPageRoute(
            builder: (_) => const ProfileSettingsScreen(),
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
