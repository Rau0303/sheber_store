import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var logger = Logger(printer:PrettyPrinter());

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

Future<void> signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
  try {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        logger.i('Автоматическая верификация прошла успешно.');
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        logger.e('Ошибка верификации: ${e.message}');
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
        logger.i('Код отправлен на номер $phoneNumber, verificationId: $verificationId');
        Navigator.of(context).pushNamed(
          '/sms_verification',
          arguments: {'verificationId': verificationId},
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        logger.w('Время ожидания истекло для verificationId: $verificationId');
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
  } catch (e) {
    logger.e('Произошла ошибка при верификации номера телефона: $e');
  }
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
