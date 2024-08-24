import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheber_market/models/basket_item.dart';
import 'package:sheber_market/models/order.dart' as app_order;
import 'package:sheber_market/models/order.dart';
import 'package:sheber_market/models/user_address.dart';
import 'package:sheber_market/models/user_bank_card.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/address_screen/address_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen.dart';
import 'package:sheber_market/screens/main/main_screen/main_screen.dart';
import 'package:sheber_market/widgets/order_product_item.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/address_widget.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/delivery_method_card.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/order_summary.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/payment_method_card.dart';

class CheckoutScreen extends StatefulWidget {
  final List<BasketItem> basketItems;
  final double total;

  const CheckoutScreen({super.key, required this.basketItems, required this.total});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'Выберите способ оплаты';
  String selectedDeliveryMethod = 'Выберите способ доставки';
  String address = '';
  double totalPrice = 0.0;
  UserAddress? selectedAddress;
  UserBankCard? selectedCard; // Убираем final
  bool isLoading = false;
  

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    recalculateTotalPrice(widget.total);
  }

  void updateSelectedPaymentMethod(String newMethod) {
    setState(() {
      selectedPaymentMethod = newMethod;
    });
  }

  void updateSelectedDeliveryMethod(String newMethod) {
    setState(() {
      selectedDeliveryMethod = newMethod;
      if (selectedDeliveryMethod == 'Доставка курьером') {
        _selectAddress();
      }
    });
  }

  void updateAddress(UserAddress newAddress) {
    setState(() {
      selectedAddress = newAddress;
      address = '${newAddress.city}, ${newAddress.street}, ${newAddress.house}, ${newAddress.apartment}';
    });
  }

  Future<void> _selectAddress() async {
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

  Future<void> _selectPaymentMethod() async {
     selectedCard = await Navigator.push<UserBankCard>(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentCardsScreen(isSelectionMode: true),
      ),
    );
    if (selectedCard != null) {
      setState(() {
        selectedCard = selectedCard;
      });
    }
  }

  void recalculateTotalPrice(double basketTotal) {
    double finalTotal = basketTotal;
    if (basketTotal < 50000 && selectedDeliveryMethod == 'Доставка курьером') {
      finalTotal += 1500;
    }
    setState(() {
      totalPrice = finalTotal;
    });
  }

Future<void> placeOrder() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  const double pi = 3.1415926535897932;

  if (userId == null) {
    showSnackBar('Вы не авторизованы.');
    return;
  }

  if (selectedPaymentMethod == 'Выберите способ оплаты' || selectedDeliveryMethod == 'Выберите способ доставки') {
    showSnackBar('Выберите правильный метод доставки и оплаты.');
    return;
  }

  // Устанавливаем фиктивный адрес, если выбран самовывоз
  UserAddress? addressForOrder;
  if (selectedDeliveryMethod == 'Самовывоз') {
    addressForOrder = UserAddress(
      id: 0, // Можно использовать значение по умолчанию
      userId: userId,
      city: 'САМОВЫЗОВ', // Указываем, что адрес не требуется
      street: 'САМОВЫЗОВ',
      house: 'САМОВЫЗОВ',
      apartment: 'САМОВЫЗОВ',
    );
  } else if (selectedAddress == null) {
    showSnackBar('Выберите адрес для доставки.');
    return;
  } else {
    addressForOrder = selectedAddress;
  }

  if (selectedPaymentMethod == 'Оплата картой') {
    showSnackBar('Оплата картой в процессе разработки.');
    return;
  }

  setState(() {
    isLoading = true;
  });
  int id = (DateTime.now().millisecond * pi).toInt();
  try {
    final order = app_order.Order(
      id: id.toString(),
      userId: userId,
      orderDate: DateTime.now(),
      totalPrice: totalPrice,
      deliveryAddress: addressForOrder!,
      status: 'Новый',
      paymentMethod: _mapPaymentMethodToEnum(selectedPaymentMethod),
      deliveryMethod: _mapDeliveryMethodToEnum(selectedDeliveryMethod),
      orderedProducts: widget.basketItems,
    );

    await _firestore.collection('orders').add(order.toMap());

    showSnackBar('Заказ успешно создан!');
    setState(() {
      // Очищаем корзину
      // Нужно получить BasketLogic и очистить корзину
      BasketLogic basketLogic = BasketLogic(context);
      basketLogic.basket.clear();
    });

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
    setState(() {
      isLoading = false;
    });
  }
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оформление заказа'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            children: [
              for (final item in widget.basketItems)
                OrderProductItem(item: item),
              DeliveryMethodCard(
                selectedDeliveryMethod: selectedDeliveryMethod,
                onChanged: (newValue) {
                  updateSelectedDeliveryMethod(newValue!);
                },
              ),
              if (selectedDeliveryMethod == 'Доставка курьером' && selectedAddress != null)
                AddressWidget(
                  screenSize: screenSize,
                  address: address,
                  onPressed: _selectAddress,
                ),
              PaymentMethodCard(
                selectedPaymentMethod: selectedPaymentMethod,
                onChanged: (newValue) {
                  updateSelectedPaymentMethod(newValue!);
                  if (selectedPaymentMethod == 'Оплата картой') {
                    _selectPaymentMethod();
                  }
                },
              ),
              if (selectedPaymentMethod == 'Оплата картой' && selectedCard != null)
                ListTile(
                  title: Text('Карта: ${selectedCard!.cardNumber}'),
                  subtitle: Text('Срок действия: ${selectedCard!.cardExpiry}'),
                  leading: const Icon(Icons.credit_card),
                ),
              OrderSummary(
                totalPrice: totalPrice,
                selectedDeliveryMethod: selectedDeliveryMethod,
                onOrder: placeOrder,
              ),
            ],
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
