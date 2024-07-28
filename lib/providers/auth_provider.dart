import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Автоматическая верификация (напр., Google Play Services)
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Ошибка верификации
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Verification Failed'),
            content: Text(e.message ?? 'Unknown error occurred.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // Код отправлен на телефон
        Navigator.of(context).pushNamed(
          '/sms_verification',
          arguments: {'verificationId': verificationId},
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Время ожидания истекло
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Timeout'),
            content: const Text('Verification code timeout. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void verifySmsCode(BuildContext context, String verificationId, String smsCode,
      {required VoidCallback onSuccess, required Function(String) onError}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }
}
