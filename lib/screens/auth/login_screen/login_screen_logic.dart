import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginScreenLogic {
  final MaskedTextController phoneNumberController;
  final Logger logger;

  // Конструктор класса, инициализирует контроллер номера телефона и логгер
  LoginScreenLogic({
    required this.phoneNumberController, 
    required this.logger});

  // Метод для обработки логики аутентификации
  void login(BuildContext context) {
    // Получаем номер телефона из контроллера
    final phoneNumber = phoneNumberController.text;

    // Проверяем, что номер телефона не пустой
    if (phoneNumber.isEmpty) {
      _showErrorDialog(context, 'Введите номер телефона');
      return;
    }

    // Логируем попытку аутентификации
    logger.i('Попытка аутентификации с номером: $phoneNumber');

    // Здесь можно добавить вызов к API или другую логику для аутентификации
    // Пока что показываем диалог успешной аутентификации как пример
    _showSuccessDialog(context);
  }

  // Метод для отображения диалога об ошибке
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ошибка'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Закрываем диалог
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }

  // Метод для отображения диалога об успешной аутентификации
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Успех'),
          content: const Text('Аутентификация успешна'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Закрываем диалог
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }
}
