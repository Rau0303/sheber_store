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
    final theme = Theme.of(context);
    final isDarkTheme = Brightness.dark ==theme.brightness;
    bool isStock = product.quantity>0 ? true : false;

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
            color:isDarkTheme?Colors.grey.shade700:Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              if (product.photo == null)
                Container(
                  width: screenSize.width * 0.35,
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
                  width: screenSize.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(product.photo!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(width:10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    Text(
                        product.name,
                        style: theme.textTheme.displayMedium,
                      ),
                    Text(
                        'Цена: ${product.sellingPrice} тг',
                        style: theme.textTheme.headlineLarge?.copyWith(color: Colors.green,fontWeight: FontWeight.bold)
                      ),
                    Text(
                      isStock?'Есть в наличии':'Нет в наличии',
                      style: theme.textTheme.headlineLarge?.copyWith(color: isStock?Colors.green:Colors.red),
                    )

                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
