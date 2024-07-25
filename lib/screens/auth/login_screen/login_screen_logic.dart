import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

    // Добавьте вашу логику аутентификации здесь
    // Например, если аутентификация успешна, перейдите на другой экран

    // Пример успешной аутентификации и перехода на экран SMS верификации
    Navigator.pushNamed(
      context,
      '/sms_verification',
      arguments: {'verificationId': 'example_verification_id'}, // Передайте необходимые параметры
    );
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

  void _showSuccessDialog(BuildContext context) {
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
  }
}
