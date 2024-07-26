import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:sheber_market/models/product.dart';

class ProductInformLogic {
  void toggleFavorite(Product product, Set<int> favoriteProductIds, Function(int) onFavoriteToggled) {
    if (favoriteProductIds.contains(product.id)) {
      favoriteProductIds.remove(product.id);
    } else {
      favoriteProductIds.add(product.id);
    }
    onFavoriteToggled(product.id);
  }

  void addToBasket(BuildContext context, Product product, List<Product> basket, Function() onProductAdded) {
    final isProductInBasket = basket.any((p) => p.id == product.id);
    if (isProductInBasket) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Продукт уже в корзине')),
      );
    } else {
      Vibration.vibrate(duration: 50);
      basket.add(product);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Продукт добавлен в корзину')),
      );
      onProductAdded();
    }
  }
}
