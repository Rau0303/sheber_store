import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/theme/adaptive_theme.dart';
import 'package:vibration/vibration.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int quantity;
  final double total;
  final Function() onTap;
  final Function() on;
  final Product product;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.quantity,
    required this.total,
    required this.onTap,
    required this.on,
    required this.product,
  });

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  bool _isFavorite = false;

  void toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AdaptiveTheme.of(context);
    final screenSize = MediaQuery.of(context).size;

    String limitedDescription = widget.description.length > 20
        ? '${widget.description.substring(0, 20)}...'
        : widget.description;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Row(
              children: [
                // Изображение продукта
                Container(
                  width: screenSize.width * 0.25,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Основное содержание
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: theme.textTheme.titleLarge!.fontSize! * 1.2, // Увеличенный размер шрифта
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        limitedDescription,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Цена: ${widget.total.toStringAsFixed(2)} тг',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.quantity > 10
                            ? 'Есть в наличии'
                            : 'Осталось ${widget.quantity} шт.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: widget.quantity > 10 ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          widget.on();
                          Vibration.vibrate(duration: 50);
                        },
                        child: const Text('В корзину'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: toggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
