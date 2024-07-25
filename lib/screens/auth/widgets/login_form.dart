import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/services.dart';
import 'package:sheber_market/widgets/save_button.dart';

class LoginForm extends StatelessWidget {
  final MaskedTextController phoneNumberController;
  final VoidCallback onLoginPressed;

  const LoginForm({
    super.key,
    required this.phoneNumberController,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      height: screenSize.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(60),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.02),
            Text(
              'Авторизация',
              style: theme.textTheme.headlineLarge,
            ),
            SizedBox(height: screenSize.height * 0.03),
            TextFormField(
              key: const Key('phoneField'),
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Введите номер телефона',
                hintStyle: theme.textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                if (value.length == 17) {
                  FocusScope.of(context).unfocus(); // Закрыть клавиатуру
                }
              },
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
            ),
            SizedBox(height: screenSize.height * 0.03),
            Savebutton(onPressed: onLoginPressed, text: 'Войти',),
          ],
        ),
      ),
    );
  }
}
