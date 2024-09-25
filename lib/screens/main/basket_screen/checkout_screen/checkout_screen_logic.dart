import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheber_market/models/order.dart' as app_order;
import 'package:sheber_market/models/basket_item.dart';
import 'package:sheber_market/models/order.dart';
import 'package:sheber_market/models/user_address.dart';
import 'package:sheber_market/models/user_bank_card.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/address_screen/address_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/address_screen/address_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen_logic.dart';
import 'package:sheber_market/screens/main/main_screen/main_screen.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen_logic.dart';

class CheckoutLogic extends ChangeNotifier {
  String selectedPaymentMethod = 'Выберите способ оплаты';
  String selectedDeliveryMethod = 'Выберите способ доставки';
  String address = '';
  double totalPrice = 0.0;
  UserAddress? selectedAddress;
  UserBankCard? selectedCard;
  bool isLoading = false;

  final BuildContext context;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CheckoutLogic(this.context);

  void updateSelectedPaymentMethod(String newMethod) {
    selectedPaymentMethod = newMethod;
    notifyListeners();
  }

  void updateSelectedDeliveryMethod(String newMethod) {
    selectedDeliveryMethod = newMethod;
    notifyListeners();
  }

  void updateAddress(UserAddress newAddress) {
    selectedAddress = newAddress;
    address = '${newAddress.city}, ${newAddress.street}, ${newAddress.house}, ${newAddress.apartment}';
    notifyListeners();
  }

  Future<void> setAddressFromScreen(BuildContext context) async {
    final addressLogic = AddressLogic(context);
    await addressLogic.loadUserAddresses();

    if (addressLogic.selectedAddress != null) {
      updateAddress(addressLogic.selectedAddress!);
    } else {
      final selectedAddress = await Navigator.push<UserAddress>(
        context,
        MaterialPageRoute(
          builder: (context) => const AddressScreen(isSelectionMode: true),
        ),
      );
      if (selectedAddress != null) {
        updateAddress(selectedAddress);
      }
    }
  }

  Future<void> setPaymentMethodFromScreen(BuildContext context) async {
    final paymentCardsLogic = PaymentCardsLogic(context);
    await paymentCardsLogic.loadCards();

    if (paymentCardsLogic.selectedCard == null) {
      final selectedCard = await Navigator.push<UserBankCard>(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentCardsScreen(isSelectionMode: true),
        ),
      );
      if (selectedCard != null) {
        updateCard(selectedCard);
      }
    } else {
      updateCard(paymentCardsLogic.selectedCard!);
    }
  }

  void updateCard(UserBankCard card) {
    selectedCard = card;
    notifyListeners();
  }

  void recalculateTotalPrice(double basketTotal) {
    totalPrice = calculateTotalPrice(basketTotal);
  }

  double calculateTotalPrice(double basketTotal) {
    double finalTotal = basketTotal;
    if (basketTotal < 50000 && selectedDeliveryMethod == 'Доставка курьером') {
      finalTotal += 1500;
    }
    return finalTotal;
  }

  /// Метод для генерации уникального номера заказа на 12 цифр
String generateUniqueOrderId() {
  // Получаем текущую временную метку
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  // Генерируем случайное число от 1000 до 9999
  int randomPart = Random().nextInt(90000) + 10000;

  // Склеиваем временную метку и случайное число
  String orderId = '$timestamp$randomPart';

  // Обрезаем длину до 16 символов (или любой другой длины, если нужно)
  return orderId;
}

  Future<void> placeOrder(List<BasketItem> basketItems) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      showSnackBar('Вы не авторизованы.');
      return;
    }

    if (selectedPaymentMethod == 'Выберите способ оплаты' || selectedDeliveryMethod == 'Выберите способ доставки') {
      showSnackBar('Выберите правильный метод доставки и оплаты.');
      return;
    }

    if (selectedPaymentMethod == 'Оплата картой') {
      showSnackBar('Оплата картой в процессе разработки.');
      return;
    }

    setLoading(true);

    try {
      // Генерация уникального 12-значного номера заказа
      String orderId = generateUniqueOrderId();

      // Проверяем, если выбран метод "Самовывоз", адрес доставки не нужен
      UserAddress? deliveryAddress;
      if (selectedDeliveryMethod != 'Самовывоз') {
        if (selectedAddress == null) {
          showSnackBar('Выберите адрес доставки.');
          setLoading(false);
          return;
        }
        deliveryAddress = selectedAddress!;
      }

      final order = app_order.Order(
        id: orderId,  // Уникальный ID с 12 цифрами
        userId: userId,
        orderDate: DateTime.now(),
        totalPrice: totalPrice,
        deliveryAddress: deliveryAddress ?? UserAddress(
          city: 'Самовывоз',
          street: 'Самовывоз',
          house: 'Самовывоз',
          apartment: 'Самовывоз', id: 0, userId: FirebaseAuth.instance.currentUser?.uid??'0',
        ),
        status: 'Новый',
        paymentMethod: _mapPaymentMethodToEnum(selectedPaymentMethod),
        deliveryMethod: _mapDeliveryMethodToEnum(selectedDeliveryMethod),
        orderedProducts: basketItems,
      );

      await _firestore.collection('orders').add(order.toMap());

      showSnackBar('Заказ успешно создан!');
      BasketLogic basketLogic = BasketLogic(context);
      basketLogic.basket.clear();
      notifyListeners();

      // Перенаправление на главный экран
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false,
        );
      });

    } catch (e) {
      print('Ошибка при создании заказа: $e');
      showSnackBar('Ошибка при создании заказа.');
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void showSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  PaymentMethod _mapPaymentMethodToEnum(String paymentMethod) {
    switch (paymentMethod) {
      case 'Оплата картой':
        return PaymentMethod.card;
      case 'Оплата наличными':
        return PaymentMethod.cash;
      default:
        return PaymentMethod.undefined;
    }
  }

  DeliveryMethod _mapDeliveryMethodToEnum(String deliveryMethod) {
    switch (deliveryMethod) {
      case 'Доставка курьером':
        return DeliveryMethod.courier;
      case 'Самовывоз':
        return DeliveryMethod.pickup;
      default:
        return DeliveryMethod.undefined;
    }
  }
}
