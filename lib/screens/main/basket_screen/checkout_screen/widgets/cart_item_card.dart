import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final Size screenSize;

  const CartItemCard({super.key, required this.screenSize});

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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenSize.height * 0.2,
              width: screenSize.width * 0.35,
              decoration: BoxDecoration(
                color: theme.cardColor, // Цвет фона карты
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/sample.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Товар',
                      style: textTheme.titleMedium, // Используем стиль из темы
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Количество: ',
                          style: textTheme.bodyMedium, // Используем стиль из темы
                        ),
                        Text(
                          '1',
                          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold), // Используем стиль из темы
                        ),
                      ],
                    ),
                    trailing: Text(
                      '1000 \u20B8',
                      style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary), // Используем цвет из темы
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
