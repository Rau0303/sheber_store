import 'package:flutter/material.dart';
import 'package:sheber_market/theme/adaptive_theme.dart';
import 'package:sheber_market/router/app_router.dart'; // Убедитесь, что роутер импортирован

class SheberMarketApp extends StatelessWidget {
  const SheberMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveTheme.getTheme(context); // Получите тему здесь
    final darkTheme = AdaptiveTheme.getDarkTheme(context); // Получите тёмную тему здесь

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sheber Store',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/main',
      onGenerateRoute: AppRouter.generateRoute, // Убедитесь, что роутер используется
    );
  }
}
