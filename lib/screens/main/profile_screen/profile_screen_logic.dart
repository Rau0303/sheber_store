import 'package:flutter/material.dart';
import 'package:sheber_market/models/users.dart';

class ProfileScreenLogic extends ChangeNotifier {
  User? user;
  bool isLoading = false;

  Future<void> loadUserProfile() async {
    isLoading = true;
    notifyListeners();

    // Mock user data; replace with real data loading logic
    await Future.delayed(const Duration(seconds: 2));
    user = User(
      id: 1,
      name: 'Имя пользователя',
      phoneNumber: '+1234567890',
      photo: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
    );

    isLoading = false;
    notifyListeners();
  }

  void navigateTo(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/address-settings');
        break;
      case 1:
        Navigator.pushNamed(context, '/address-settings');
        break;
      case 2:
        Navigator.pushNamed(context, '/address-settings');
        break;
      case 3:
        Navigator.pushNamed(context, '/address-settings');
        break;
      case 4:
        Navigator.pushNamed(context, '/address-settings');
        break;
      default:
        break;
    }
  }
}
