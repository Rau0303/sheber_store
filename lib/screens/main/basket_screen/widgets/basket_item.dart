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
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness==Brightness.dark;

    return Container(
      height: screenSize.height * 0.20,
      width: screenSize.width,
      decoration: BoxDecoration(
        color:isDarkTheme? Colors.grey.shade700 :Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Container(
              height: screenSize.height ,
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
                  Text(item.product.name,softWrap: true,style: theme.textTheme.displaySmall,),
                  Text(
                    '${item.product.sellingPrice.toStringAsFixed(2)} тг',
                    style: theme.textTheme.headlineLarge?.copyWith(color: Colors.green,fontWeight: FontWeight.bold),
                  ),
                  
                  Row(
                    children: [
                      IconButton(
                        onPressed: onAdd,
                        icon: const Icon(Icons.add),
                      ),
                      Text('${item.quantity}',style: theme.textTheme.bodyLarge,),
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
