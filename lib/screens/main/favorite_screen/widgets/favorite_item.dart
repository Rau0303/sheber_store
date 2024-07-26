import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/screens/main/favorite_screen/favorites_screen_logic.dart';


class FavoriteItem extends StatelessWidget {
  final Product product;

  const FavoriteItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Dismissible(
        key: Key(product.id.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          // Логика для удаления из избранного
          final logic = Provider.of<FavoritesLogic>(context, listen: false);
          logic.showDeleteFavoritesDialog(product);
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Container(
          height: screenSize.height * 0.18,
          width: screenSize.width,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              if (product.photo == null)
                Container(
                  width: screenSize.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/noshki.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  width: screenSize.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(product.photo!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Expanded(
                child: ListTile(
                  title: Text(
                    product.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${product.sellingPrice} ${product.unit}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
