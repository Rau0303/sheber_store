import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/providers/auth_provider.dart';


class SmsVerificationLogic {
  final TextEditingController smsController;

  SmsVerificationLogic({required this.smsController});

  void verify(BuildContext context, String verificationId) {
    final smsCode = smsController.text.trim();
    if (smsCode.length == 6) {
      // Используем AuthProvider для проверки кода
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.verifySmsCode(
        context,
        verificationId,
        smsCode,
        onSuccess: () {
          Navigator.pushNamed(context, '/main');
        },
        onError: (error) {
          _showErrorDialog(context, error);
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите корректный код верификации'),
        ),
      );
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ошибка'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }
}
