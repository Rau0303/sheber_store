import 'package:flutter/material.dart';
import 'package:sheber_market/models/basket_item.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/address_widget.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/delivery_method_card.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/order_summary.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/payment_method_card.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/address_screen/address_screen.dart';
import 'package:sheber_market/widgets/order_product_item.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen.dart'; // Импорт экрана выбора карт

class CheckoutScreen extends StatefulWidget {
  final List<BasketItem> basketItems;

  const CheckoutScreen({super.key, required this.basketItems});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'Выберите способ оплаты';
  String selectedDeliveryMethod = 'Выберите способ доставки';
  String address = '';
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.basketItems.fold(
      0.0,
      (sum, item) => sum + item.product.sellingPrice * item.quantity,
    );
  }

  Future<void> _selectAddress() async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddressScreen(),
      ),
    );

    if (selectedAddress != null) {
      setState(() {
        address = selectedAddress as String; // Обновите это, если адрес - это другой тип данных
      });
    }
  }

  Future<void> _selectPaymentMethod() async {
    final selectedCard = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentCardsScreen(),
      ),
    );

    if (selectedCard != null) {
      setState(() {
        selectedPaymentMethod = selectedCard as String; // Обновите это, если карта - это другой тип данных
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оформление заказа'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        children: [
          for (final item in widget.basketItems)
            OrderProductItem(item: item),
          DeliveryMethodCard(
            selectedDeliveryMethod: selectedDeliveryMethod,
            onChanged: (newValue) {
              setState(() {
                selectedDeliveryMethod = newValue!;
                if (selectedDeliveryMethod == 'Доставка курьером') {
                  _selectAddress(); // Открытие экрана выбора адреса
                }
              });
            },
          ),
          if (selectedDeliveryMethod == 'Доставка курьером')
            AddressWidget(
              screenSize: screenSize,
              address: address,
              onPressed: () {
                _selectAddress(); // Открытие экрана выбора адреса
              },
            ),
          PaymentMethodCard(
            selectedPaymentMethod: selectedPaymentMethod,
            onChanged: (newValue) {
              setState(() {
                selectedPaymentMethod = newValue!;
                if (selectedPaymentMethod == 'Оплата картой') {
                  _selectPaymentMethod(); // Открытие экрана выбора карт
                }
              });
            },
          ),
          OrderSummary(
            totalPrice: totalPrice,
            selectedDeliveryMethod: selectedDeliveryMethod,
            onOrder: () {
              // Логика оформления заказа
            },
          ),
        ],
      ),
    );
  }
}
