import 'package:flutter/material.dart';
import 'package:sheber_market/models/basket_item.dart';

class OrderProductItem extends StatelessWidget {
  final BasketItem item;

  const OrderProductItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.20,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Container(
              height: screenSize.height,
              width: screenSize.width * 0.35,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: item.product.photo?.isEmpty ?? true
                      ? const AssetImage('assets/noshki.jpg') as ImageProvider
                      : NetworkImage(item.product.photo!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.name, softWrap: true),
                  Text(
                    '${item.product.sellingPrice.toStringAsFixed(2)} тг',
                    style: const TextStyle(color: Colors.green),
                  ),
                  Text('Количество: ${item.quantity}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
