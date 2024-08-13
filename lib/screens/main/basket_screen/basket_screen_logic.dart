import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/basket_item.dart';
import 'package:sheber_market/models/cart_item.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BasketLogic extends ChangeNotifier {
  final BuildContext context;
  BasketLogic(this.context);

  List<BasketItem> basket = [];

  Future<void> loadBasket() async {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.fetchCartItems();
    basket = await Future.wait(cartProvider.cartItems.map((item) async {
      final product = await fetchProductById(item.productId);
      return BasketItem(
        title: product.name,
        price: product.sellingPrice,
        quantity: item.quantity,
        photoURLs: product.photo!,
      );
    }));
    notifyListeners();
  }

  Future<Product> fetchProductById(int productId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId.toString())
          .get();

      if (doc.exists) {
        return Product.fromMap(doc.data()!);
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      print("Error fetching product: $e");
      throw e; // Обязательно выбросите исключение, чтобы функция всегда возвращала значение
    }
  }

  Future<void> addProduct(BasketItem item, int quantity) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.addCartItem(CartItem(
      productId: item.title.hashCode, // Используйте правильный идентификатор продукта
      quantity: quantity,
    ));
    await loadBasket(); // Обновите корзину после добавления товара
  }

  Future<void> removeProduct(BasketItem item) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.deleteCartItem(item.title.hashCode); // Используйте правильный идентификатор продукта
    await loadBasket(); // Обновите корзину после удаления товара
  }

  Future<void> showClearBasketDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Очистить корзину?'),
          content: const Text('Вы уверены, что хотите очистить корзину? Это действие нельзя отменить.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await clearBasket();
              },
              child: const Text('Очистить'),
            ),
          ],
        );
      },
    );
  }

  Future<void> clearBasket() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.clearCart();
    basket.clear();
    notifyListeners();
  }

  int calculateTotalQuantity() {
    return basket.fold(0, (sum, item) => sum + item.quantity);
  }

  double calculateTotalPrice() {
    return basket.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double calculateRemainingAmountForFreeDelivery(double totalPrice, double freeDeliveryThreshold) {
    return freeDeliveryThreshold - totalPrice;
  }

  bool isEligibleForFreeDelivery(double totalPrice, double freeDeliveryThreshold) {
    return totalPrice >= freeDeliveryThreshold;
  }

  void proceedToCheckout(BuildContext context) {
    // Логика оформления заказа
  }
}
