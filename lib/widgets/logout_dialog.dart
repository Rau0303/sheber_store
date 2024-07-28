import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({required this.onLogout, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'Выход из аккаунта',
        style: theme.textTheme.headlineMedium,
      ),
      content: Text(
        'Вы уверены, что хотите выйти из аккаунта?',
        style: theme.textTheme.bodyMedium,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Отмена',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: theme.textTheme.titleLarge?.fontSize,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Выход',
            style: TextStyle(
              color: theme.colorScheme.error,
              fontSize: theme.textTheme.titleLarge?.fontSize,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onLogout();
          },
        ),
      ],
    );
  }
}
