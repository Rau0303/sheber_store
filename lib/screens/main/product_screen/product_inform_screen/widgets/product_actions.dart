import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';

class ProductActions extends StatelessWidget {
  const ProductActions({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onAddToBasket,
    required this.onToggleFavorite,
  });

  final Product product;
  final bool isFavorite;
  final VoidCallback onAddToBasket;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Container(
      height: screenSize.height * 0.1,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // Используем фон из темы
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.1,
          vertical: screenSize.height * 0.02,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${product.sellingPrice} ₸',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary, // Используем основной цвет из темы
              ),
            ),
            ElevatedButton(
              onPressed: product.quantity > 0 ? onAddToBasket : null,
              child: Text(
                'В корзину',
                style: theme.textTheme.labelMedium, // Используем labelMedium для текста в кнопке
              ),
            ),
            IconButton(
              onPressed: onToggleFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
