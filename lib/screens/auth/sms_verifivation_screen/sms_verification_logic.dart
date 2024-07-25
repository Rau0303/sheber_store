import 'package:flutter/material.dart';

class SmsVerificationLogic {
  final TextEditingController smsController;

  SmsVerificationLogic({required this.smsController});

  void verify(BuildContext context, String verificationId) {
    // Логика для верификации кода SMS
    final smsCode = smsController.text.trim();
    if (smsCode.length == 6) {
      // Здесь вы можете добавить логику для отправки кода верификации на сервер или проверки его
      // Например, можно вызвать API или использовать метод для проверки кода
      
      // Переход к следующему экрану после успешной проверки
      Navigator.pushNamed(context, '/nextScreen');  // Замените '/nextScreen' на нужный маршрут
    } else {
      // Показать сообщение об ошибке
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите корректный код верификации'),
        ),
      );
    }
  }
}
