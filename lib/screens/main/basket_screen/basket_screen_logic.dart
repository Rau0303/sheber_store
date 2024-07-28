import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/basket_item.dart';
import 'package:sheber_market/models/cart_item.dart';
import 'package:sheber_market/providers/cart_provider.dart';

class BasketLogic extends ChangeNotifier {
  final BuildContext context;
  BasketLogic(this.context);

  List<BasketItem> basket = []; // Инициализируйте пустую корзину

  // Загрузка данных из локальной базы данных
  Future<void> loadBasket() async {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.fetchCartItems();
    basket = cartProvider.cartItems.map((item) => BasketItem(
      title: '', // Заполните данные продукта
      price: 0.0,
      quantity: item.quantity,
      photoURLs: [], // Заполните URL фото
    )).toList();
    notifyListeners();
  }

  // Добавить товар в корзину
  Future<void> addProduct(BasketItem item, int quantity) async {
    final index = basket.indexWhere((i) => i.title == item.title);
    if (index != -1) {
      basket[index] = BasketItem(
        title: basket[index].title,
        price: basket[index].price,
        quantity: basket[index].quantity + quantity,
        photoURLs: basket[index].photoURLs,
      );
    } else {
      basket.add(item);
    }
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.addCartItem(CartItem(
      productId: item.title.hashCode, // Пример productId, используйте правильный идентификатор
      quantity: quantity,
    ));
    notifyListeners();
  }

  // Удалить товар из корзины
  Future<void> removeProduct(BasketItem item) async {
    basket.removeWhere((i) => i.title == item.title);
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.deleteCartItem(item.title.hashCode); // Пример productId, используйте правильный идентификатор
    notifyListeners();
  }

  // Показать диалог для очистки корзины
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

  // Очистить корзину
  Future<void> clearBasket() async {
    basket.clear();
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.clearCart();
    notifyListeners();
  }

  // Рассчитать общее количество товаров
  int calculateTotalQuantity() {
    return basket.fold(0, (sum, item) => sum + item.quantity);
  }

  // Рассчитать общую цену
  double calculateTotalPrice() {
    return basket.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Рассчитать оставшуюся сумму для бесплатной доставки
  double calculateRemainingAmountForFreeDelivery(double totalPrice, double freeDeliveryThreshold) {
    return freeDeliveryThreshold - totalPrice;
  }

  // Проверить право на бесплатную доставку
  bool isEligibleForFreeDelivery(double totalPrice, double freeDeliveryThreshold) {
    return totalPrice >= freeDeliveryThreshold;
  }

  // Перейти к оформлению заказа
  void proceedToCheckout(BuildContext context) {
    // Логика оформления заказа
  }
}
