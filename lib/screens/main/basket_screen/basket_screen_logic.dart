import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Импортируем пакет для работы с SharedPreferences
import 'dart:convert';
import 'package:sheber_market/models/basket_item.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/checkout_screen.dart';

class BasketLogic extends ChangeNotifier {
  final BuildContext context;
  BasketLogic(this.context) {
    loadBasket(); // Загружаем корзину при инициализации
  }

  List<BasketItem> basket = [];

Future<void> loadBasket() async {
  final prefs = await SharedPreferences.getInstance();
  final basketJson = prefs.getString('basket');
  if (basketJson != null) {
    final List<dynamic> basketList = jsonDecode(basketJson);
    basket = basketList.map((item) => BasketItem.fromJson(item)).toList();
  } else {
    basket = []; // Инициализация пустой корзиной
  }
  notifyListeners();
}


  Future<void> saveBasket() async {
    final prefs = await SharedPreferences.getInstance();
    final basketJson = jsonEncode(basket.map((item) => item.toJson()).toList());
    prefs.setString('basket', basketJson);
  }

Future<void> addProduct(Product product, int quantity) async {
  final existingItemIndex = basket.indexWhere((item) => item.product.id == product.id);

  if (existingItemIndex != -1) {
    basket[existingItemIndex] = BasketItem(
      product: product,
      quantity: basket[existingItemIndex].quantity + quantity,
    );
  } else {
    basket.add(BasketItem(
      product: product,
      quantity: quantity,
    ));
  }

  await saveBasket();
  notifyListeners();
}

Future<void> removeProduct(BasketItem item) async {
  final existingItemIndex = basket.indexWhere((i) => i.product.id == item.product.id);

  if (existingItemIndex != -1) {
    final currentItem = basket[existingItemIndex];
    if (currentItem.quantity > 1) {
      basket[existingItemIndex] = BasketItem(
        product: currentItem.product,
        quantity: currentItem.quantity - 1,
      );
    } else {
      basket.removeAt(existingItemIndex);
    }

    await saveBasket();
    notifyListeners();
  }
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
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('basket'); // Удаляем данные из SharedPreferences
  basket.clear(); // Очищаем список корзины
  await saveBasket(); // Сохраняем пустую корзину
  notifyListeners();
}



  int calculateTotalQuantity() {
    return basket.fold(0, (sum, item) => sum + item.quantity);
  }

  double calculateTotalPrice() {
    return basket.fold(0.0, (sum, item) => sum + (item.product.sellingPrice * item.quantity));
  }

  double calculateRemainingAmountForFreeDelivery(double totalPrice, double freeDeliveryThreshold) {
    return freeDeliveryThreshold - totalPrice;
  }

  bool isEligibleForFreeDelivery(double totalPrice, double freeDeliveryThreshold) {
    return totalPrice >= freeDeliveryThreshold;
  }


}
