import 'package:flutter/material.dart';
import 'package:sheber_market/models/users.dart';


class ProfileScreenLogic extends ChangeNotifier {
  final BuildContext context;

  ProfileScreenLogic(this.context);

  User? user;
  bool isLoading = false;

  Future<void> loadUserProfile() async {
    isLoading = true;
    notifyListeners(); // Notify listeners that loading state has changed

    // Mock user data; replace with real data loading logic
    await Future.delayed(const Duration(seconds: 2));
    user = User(
      id: 1,
      name: 'Имя пользователя',
      phoneNumber: '+1234567890',
      photo: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
    );

    isLoading = false;
    notifyListeners(); // Notify listeners that data has been updated
  }

  void navigateTo(int index) {
    switch (index) {
      case 0:
        
        break;
      case 1:
        
        break;
      case 2:
        
        break;
      case 3:
        
        break;
      case 4:
        
        break;
      default:
        break;
    }
  }
}
