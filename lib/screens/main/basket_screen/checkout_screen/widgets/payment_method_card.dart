import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final String selectedPaymentMethod;
  final ValueChanged<String?> onChanged;

  const PaymentMethodCard({
    super.key,
    required this.selectedPaymentMethod,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Выберите способ оплаты:',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              onChanged: onChanged,
              items: <String>[
                'Выберите способ оплаты',
                'Оплата картой',
                'Наличными',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
              isExpanded: true,
              underline: const SizedBox(),
              dropdownColor: theme.scaffoldBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}