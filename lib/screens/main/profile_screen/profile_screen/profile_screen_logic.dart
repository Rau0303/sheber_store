import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/users.dart';
import 'package:sheber_market/widgets/logout_dialog.dart';

class ProfileScreenLogic extends ChangeNotifier {
  
  bool isLoading = false;

  Future<void> loadUserProfile() async {
    isLoading = true;
    notifyListeners();

    // Mock user data; replace with real data loading logic
    
    

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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LogoutDialog(onLogout: () {
            // Ваш код выхода из аккаунта
          });
        },
      );
      break;
    default:
      break;
  }
}


}
