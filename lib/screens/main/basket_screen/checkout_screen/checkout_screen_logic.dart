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

  Future<void> placeOrder(List<BasketItem> basketItems) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      _showSnackBar('Вы не авторизованы.');
      return;
    }

    if (selectedAddress == null || selectedPaymentMethod == 'Выберите способ оплаты' || selectedDeliveryMethod == 'Выберите способ доставки') {
      _showSnackBar('Выберите правильный метод доставки и оплаты.');
      return;
    }

    setLoading(true);

    try {
      final order = app_order.Order(
        id: '',
        userId: userId,
        orderDate: DateTime.now(),
        totalPrice: totalPrice,
        deliveryAddress: selectedAddress!,
        status: 'Новый',
        paymentMethod: _mapPaymentMethodToEnum(selectedPaymentMethod),
        deliveryMethod: _mapDeliveryMethodToEnum(selectedDeliveryMethod),
        orderedProducts: basketItems,
      );

      await _firestore.collection('orders').add(order.toMap());

      _showSnackBar('Заказ успешно создан!');
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

    } catch (e) {
      print('Ошибка при создании заказа: $e');
      _showSnackBar('Ошибка при создании заказа.');
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
