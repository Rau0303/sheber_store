import 'package:flutter/material.dart';

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
  UserBankCard? selectedCard; // Добавлено поле для хранения выбранной карты

  final BuildContext context;

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
  final AddressLogic addressLogic = AddressLogic(context);
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
  final PaymentCardsLogic paymentCardsLogic = PaymentCardsLogic(context);
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



  void updateCard(UserBankCard card){
    selectedCard = card;
    print('selCard $selectedCard');
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
}
