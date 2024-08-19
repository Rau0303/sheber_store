import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';

class ProductGridViewCard extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onToggleFavorite;
  final bool isFavorite;
  final VoidCallback onTap;

  const ProductGridViewCard({
    required this.product,
    required this.onAddToCart,
    required this.onToggleFavorite,
    required this.isFavorite,
    required this.onTap,
    super.key,
  });

  @override
  _ProductGridViewCardState createState() => _ProductGridViewCardState();
}

class _ProductGridViewCardState extends State<ProductGridViewCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                height: screenSize.height * 0.2,
                width: double.infinity,
                child: Image.network(
                  widget.product.photo?.isNotEmpty ?? false
                      ? widget.product.photo!
                      : 'assets/noshki.jpg',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, exception, stackTrace) {
                    return Image.asset(
                      'assets/noshki.jpg',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis, // Обрезка текста, если он длинный
                  ),
                  Text(
                    widget.product.quantity > 0
                        ? 'в наличии ${widget.product.quantity} штук'
                        : 'Нет в наличии',
                    style: widget.product.quantity > 0
                        ? textTheme.bodyMedium!.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          )
                        : textTheme.bodyMedium!.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    overflow: TextOverflow.ellipsis, // Обрезка текста
                  ),
                  Text(
                    'Цена: ${widget.product.sellingPrice.toStringAsFixed(2)}',
                    overflow: TextOverflow.ellipsis, // Обрезка текста
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: widget.onAddToCart,
                          child: Text(
                            'В корзину',
                            style: textTheme.bodyMedium!.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                          widget.onToggleFavorite();
                        },
                        icon: Icon(
                          _isFavorite
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: _isFavorite ? Colors.red : theme.iconTheme.color,
                        ),
                      ),
                    ],
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
