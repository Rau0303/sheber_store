import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final double totalPrice;
  final String selectedDeliveryMethod;
  final VoidCallback onOrder;

  const OrderSummary({
    super.key,
    required this.totalPrice,
    required this.selectedDeliveryMethod,
    required this.onOrder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    
    final double finalTotal = totalPrice + (totalPrice < 50000 && selectedDeliveryMethod == 'Доставка курьером' ? 1500 : 0);

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
              'Общая сумма товаров:',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              '${totalPrice.toStringAsFixed(2)} \u20B8',
              style: textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (totalPrice < 50000 && selectedDeliveryMethod == 'Доставка курьером')
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Стоимость доставки: 1500 \u20B8',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Итоговая сумма: ${finalTotal.toStringAsFixed(2)} \u20B8',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onOrder,
              child: const Text('Оформить заказ'),
            ),
          ],
        ),
      ),
    );
  }
}
