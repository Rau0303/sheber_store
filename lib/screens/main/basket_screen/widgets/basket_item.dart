import 'package:flutter/material.dart';
import 'package:sheber_market/models/basket_item.dart';

class BasketItemWidget extends StatelessWidget {
  final BasketItem item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const BasketItemWidget({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: screenSize.height * 0.2,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(item.product.name),
                      trailing: Text(
                        '${item.product.sellingPrice.toStringAsFixed(2)} \u20B8',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onAdd,
                        icon: const Icon(Icons.add),
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(Icons.remove),
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
