import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: textTheme.headlineMedium, // Используем headlineMedium для названия продукта
          ),
          const SizedBox(height: 8),
          Text(
            'Описание',
            style: textTheme.titleMedium, // Используем titleMedium для заголовков секций
          ),
          const SizedBox(height: 4),
          Text(
            product.description ?? 'Описание отсутствует',
            style: textTheme.bodyMedium, // Используем bodyMedium для описания
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Категории: ',
                style: textTheme.bodyMedium, // Используем bodyMedium для текста
              ),
              Text(
                product.category,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Наличие: ',
                style: textTheme.bodyMedium,
              ),
              Text(
                product.quantity > 0 ? 'В наличии' : 'Нет в наличии',
                style: TextStyle(
                  color: product.quantity > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
