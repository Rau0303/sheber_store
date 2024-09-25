import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/users.dart';
import 'package:sheber_market/providers/user_provider.dart';
import 'package:sheber_market/widgets/logout_dialog.dart';

class ProfileScreenLogic extends ChangeNotifier {
  bool isLoading = false;
  Users? _currentUser;

  Users? get currentUser => _currentUser;

  final UserProvider _userProvider = UserProvider();

  Future<void> loadUserProfile() async {
    isLoading = true;
    notifyListeners();

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await _userProvider.fetchUsersFromFirebase();
      if (_userProvider.users.isNotEmpty) {
        _currentUser = _userProvider.users.firstWhere(
          (user) => user.id.toString() == userId,
          orElse: () => Users(id: 0, name: '', phoneNumber: ''),
        );
      } else {
        _currentUser = Users(id: 0, name: '', phoneNumber: '');
      }
    } else {
      _currentUser = Users(id: 0, name: '', phoneNumber: '');
    }

    isLoading = false;
    notifyListeners();
  }

  void navigateTo(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/app-settings');
        break;
      case 1:
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          Navigator.pushNamed(
            context,
            '/user-orders',
            arguments: {'userId': userId},
          );
        } else {
          Navigator.pushNamed(context, '/error');
        }
        break;
      case 2:
        Navigator.pushNamed(context, '/terms_of_use');
        break;
      case 3:
        // Показ диалога подтверждения выхода из аккаунта
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return LogoutDialog(onLogout: () async {
              await _logout(context); // Логика выхода
            });
          },
        );
        break;
      default:
        break;
    }
  }

  // Метод выхода из аккаунта
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Выход из Firebase
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login', // После выхода перенаправляем на экран логина
        (route) => false, // Удаляем все предыдущие экраны из стека
      );
    } catch (e) {
      print("Ошибка при выходе из аккаунта: $e");
      // Возможно, добавить уведомление для пользователя о неудачной попытке выхода
    }
  }
}
