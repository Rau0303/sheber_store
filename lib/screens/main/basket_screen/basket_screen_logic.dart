import 'package:flutter/material.dart';
import 'package:sheber_market/models/basket_item.dart';

class BasketLogic extends ChangeNotifier {
  List<BasketItem> basket = []; // Инициализируйте пустую корзину

  // Добавить товар в корзину
  void addProduct(BasketItem item, int quantity) {
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
    notifyListeners();
  }

  // Удалить товар из корзины
  void removeProduct(BasketItem item) {
    basket.removeWhere((i) => i.title == item.title);
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
              onPressed: () {
                Navigator.of(context).pop();
                clearBasket();
              },
              child: const Text('Очистить'),
            ),
          ],
        );
      },
    );
  }

  // Очистить корзину
  void clearBasket() {
    basket.clear();
    notifyListeners();
  }

  // Рассчитать общее количество товаров
  int calculateTotalQuantity(List<BasketItem> basket) {
    return basket.fold(0, (sum, item) => sum + item.quantity);
  }

  // Рассчитать общую цену
  double calculateTotalPrice(List<BasketItem> basket) {
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
