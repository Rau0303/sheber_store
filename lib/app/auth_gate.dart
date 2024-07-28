import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/providers/auth_provider.dart' as custom_auth;

import 'package:sheber_market/screens/auth/login_screen/login_screen.dart';

import 'package:sheber_market/screens/main/main_screen/main_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<custom_auth.AuthProvider>(
      builder: (context, authProvider, _) {
        return FutureBuilder<firebase_auth.User?>(
          future: authProvider.getCurrentUser(), // Получаем текущего пользователя
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Показываем индикатор загрузки
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}')); // Обработка ошибок
            } else if (snapshot.hasData && snapshot.data != null) {
              return const MainScreen(); // Если пользователь аутентифицирован
            } else {
              return const LoginScreen(); // Если пользователь не аутентифицирован
            }
          },
        );
      },
    );
  }
}
