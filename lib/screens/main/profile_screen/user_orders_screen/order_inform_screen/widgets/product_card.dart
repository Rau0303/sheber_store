import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';

class OrderProductCard extends StatelessWidget {
  final Product product;
  final int quantity; // Количество
  final double price; // Цена

  const OrderProductCard({super.key, required this.product, required this.quantity, required this.price});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenSize.height * 0.2,
                  width: screenSize.width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(product.photo ?? 'https://via.placeholder.com/150'), // Заглушка
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(product.name),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Количество: '),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 8.0,
              child: Text(
                '${price.toInt()} \u20B8',
                style: const TextStyle(color: Colors.green, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
