import 'package:flutter/material.dart';
import 'package:sheber_market/screens/auth/login_screen/login_screen.dart';
import 'package:sheber_market/theme/adaptive_theme.dart';
class SheberMarketApp extends StatelessWidget {
  const SheberMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sheber Store',
      theme: AdaptiveTheme.getTheme(context),
      darkTheme: AdaptiveTheme.getDarkTheme(context),
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }
}