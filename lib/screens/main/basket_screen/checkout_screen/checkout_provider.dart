import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {
  String selectedPaymentMethod = 'Выберите способ оплаты';
  String selectedDeliveryMethod = 'Выберите способ доставки';
  String address = '';
  double totalPrice = 0.0;

  void updateSelectedPaymentMethod(String newMethod) {
    selectedPaymentMethod = newMethod;
    notifyListeners();
  }

  void updateSelectedDeliveryMethod(String newMethod) {
    selectedDeliveryMethod = newMethod;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void calculateTotalPrice(double basketTotal) {
    double finalTotal = basketTotal;
    if (basketTotal < 50000 && selectedDeliveryMethod == 'Доставка курьером') {
      finalTotal += 1500;
    }
    totalPrice = finalTotal;
    notifyListeners();
  }
}
