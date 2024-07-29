import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/address_widget.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/cart_item_card.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/delivery_method_card.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/order_summary.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/payment_method_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

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
  }

  void updateTotalPrice(double price) {
    setState(() {
      totalPrice = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оформление заказа'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CartItemCard(screenSize: screenSize),
          DeliveryMethodCard(
            selectedDeliveryMethod: selectedDeliveryMethod,
            onChanged: (newValue) {
              setState(() {
                selectedDeliveryMethod = newValue!;
              });
            },
          ),
          if (selectedDeliveryMethod == 'Доставка курьером')
            AddressWidget(
              screenSize: screenSize,
              address: address,
              onPressed: () {
                // Логика для перехода на экран выбора адреса
              },
            ),
          PaymentMethodCard(
            selectedPaymentMethod: selectedPaymentMethod,
            onChanged: (newValue) {
              setState(() {
                selectedPaymentMethod = newValue!;
              });
            },
          ),
          if (selectedPaymentMethod == 'Оплата картой')
            Container(
              height: screenSize.height * 0.15,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                title: const Text('Карта'),
                subtitle: const Text('1234 5678 1234 5678'),
                trailing: IconButton(
                  onPressed: () {
                    // Логика для перехода на экран выбора карт
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ),
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