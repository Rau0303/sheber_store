import 'package:flutter/material.dart';

class DeliveryMethodCard extends StatelessWidget {
  final String selectedDeliveryMethod;
  final ValueChanged<String?> onChanged;

  const DeliveryMethodCard({
    super.key,
    required this.selectedDeliveryMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Выберите способ доставки:',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface, // Цвет текста в соответствии с темой
              ),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedDeliveryMethod,
              onChanged: onChanged,
              items: <String>[
                'Выберите способ доставки',
                'Доставка курьером',
                'Самовывоз',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textTheme.bodyMedium), // Используем стиль из темы
                );
              }).toList(),
              style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface), // Цвет текста в соответствии с темой
              dropdownColor: theme.cardColor, // Цвет фона выпадающего меню
            ),
          ],
        ),
      ),
    );
  }
}
