import 'package:flutter/material.dart';
import 'package:sheber_market/screens/auth/login_screen/login_screen.dart';
import 'package:sheber_market/screens/auth/sms_verifivation_screen/sms_verification_screen.dart';


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
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
