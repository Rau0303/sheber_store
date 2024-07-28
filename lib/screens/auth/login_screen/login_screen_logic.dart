import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/providers/auth_provider.dart';

class LoginScreenLogic {
  final MaskedTextController phoneNumberController;
  final Logger logger;

  LoginScreenLogic({
    required this.phoneNumberController,
    required this.logger,
  });

  void login(BuildContext context) {
    final phoneNumber = phoneNumberController.text;

    if (phoneNumber.isEmpty) {
      _showErrorDialog(context, 'Введите номер телефона');
      return;
    }

    logger.i('Попытка аутентификации с номером: $phoneNumber');

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.signInWithPhoneNumber(context, phoneNumber);
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

  /*void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Успех'),
          content: const Text('Аутентификация успешна'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }*/
}
