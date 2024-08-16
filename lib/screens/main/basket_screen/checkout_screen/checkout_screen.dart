  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:sheber_market/models/basket_item.dart';
  import 'package:sheber_market/screens/main/basket_screen/checkout_screen/checkout_screen_logic.dart';

  import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/address_widget.dart';
  import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/delivery_method_card.dart';
  import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/order_summary.dart';
  import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/payment_method_card.dart';

  import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen.dart';
  import 'package:sheber_market/widgets/order_product_item.dart';

  class CheckoutScreen extends StatefulWidget {
    final List<BasketItem> basketItems;

    const CheckoutScreen({super.key, required this.basketItems});

    @override
    CheckoutScreenState createState() => CheckoutScreenState();
  }

  class CheckoutScreenState extends State<CheckoutScreen> {
    @override
    void initState() {
      super.initState();
      final checkoutLogic = Provider.of<CheckoutLogic>(context, listen: false);
      checkoutLogic.calculateTotalPrice(widget.basketItems.fold(
        0.0,
        (sum, item) => sum + item.product.sellingPrice * item.quantity,
      ));
    }

    Future<void> _selectAddress() async {
      final checkoutLogic = Provider.of<CheckoutLogic>(context, listen: false);
      checkoutLogic.setAddressFromScreen(); // Обновление адреса в логике
    }

    Future<void> _selectPaymentMethod() async {
      final selectedCard = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentCardsScreen(),
        ),
      );

      if (selectedCard != null) {
        final checkoutLogic = Provider.of<CheckoutLogic>(context, listen: false);
        checkoutLogic.updateSelectedPaymentMethod(selectedCard as String); // Обновление метода оплаты в логике
      }
    }

    @override
    Widget build(BuildContext context) {
      final checkoutLogic = Provider.of<CheckoutLogic>(context);
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
              selectedDeliveryMethod: checkoutLogic.selectedDeliveryMethod,
              onChanged: (newValue) {
                setState(() {
                  checkoutLogic.updateSelectedDeliveryMethod(newValue!);
                  if (checkoutLogic.selectedDeliveryMethod == 'Доставка курьером') {
                    _selectAddress(); // Открытие экрана выбора адреса
                  }
                });
              },
            ),
            if (checkoutLogic.selectedDeliveryMethod == 'Доставка курьером' && checkoutLogic.selectedAddress != null)
              AddressWidget(
                screenSize: screenSize,
                address: checkoutLogic.address,
                onPressed: _selectAddress, // Открытие экрана выбора адреса
              ),
            PaymentMethodCard(
              selectedPaymentMethod: checkoutLogic.selectedPaymentMethod,
              onChanged: (newValue) {
                setState(() {
                  checkoutLogic.updateSelectedPaymentMethod(newValue!);
                  if (checkoutLogic.selectedPaymentMethod == 'Оплата картой') {
                    _selectPaymentMethod(); // Открытие экрана выбора карт
                  }
                });
              },
            ),
            OrderSummary(
              totalPrice: checkoutLogic.totalPrice,
              selectedDeliveryMethod: checkoutLogic.selectedDeliveryMethod,
              onOrder: () {
                // Логика оформления заказа
              },
            ),
          ],
        ),
      );
    }
  }
