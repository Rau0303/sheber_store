import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  final Size screenSize;
  final String address;
  final VoidCallback onPressed;

  const AddressWidget({
    super.key,
    required this.screenSize,
    required this.address,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      height: screenSize.height * 0.15,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.dividerColor), // Используем цвет разделителя темы
      ),
      child: ListTile(
        title: Text(
          'Адрес',
          style: textTheme.titleLarge, // Используем стиль из темы
        ),
        subtitle: Text(
          address,
          style: textTheme.bodyMedium, // Используем стиль из темы
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: theme.iconTheme.color, // Используем цвет иконок из темы
          ),
        ),
      ),
    );
  }
}
