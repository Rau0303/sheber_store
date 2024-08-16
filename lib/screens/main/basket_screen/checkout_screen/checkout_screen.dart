import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/basket_item.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/checkout_screen_logic.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/address_widget.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/delivery_method_card.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/order_summary.dart';
import 'package:sheber_market/screens/main/basket_screen/checkout_screen/widgets/payment_method_card.dart';
import 'package:sheber_market/widgets/order_product_item.dart';

class CheckoutScreen extends StatefulWidget {
  final List<BasketItem> basketItems;
  final double total;

  const CheckoutScreen({super.key, required this.basketItems, required this.total});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    final checkoutLogic = Provider.of<CheckoutLogic>(context, listen: false);
    checkoutLogic.recalculateTotalPrice(widget.total);
  }

  Future<void> _selectAddress() async {
    final checkoutLogic = Provider.of<CheckoutLogic>(context, listen: false);
    await checkoutLogic.setAddressFromScreen(context);
  }

  Future<void> _selectPaymentMethod() async {
    final checkoutLogic = Provider.of<CheckoutLogic>(context, listen: false);
    await checkoutLogic.setPaymentMethodFromScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    final checkoutLogic = Provider.of<CheckoutLogic>(context);
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
                selectedDeliveryMethod: checkoutLogic.selectedDeliveryMethod,
                onChanged: (newValue) {
                  setState(() {
                    checkoutLogic.updateSelectedDeliveryMethod(newValue!);
                    if (checkoutLogic.selectedDeliveryMethod == 'Доставка курьером') {
                      _selectAddress();
                    }
                  });
                },
              ),
              if (checkoutLogic.selectedDeliveryMethod == 'Доставка курьером' && checkoutLogic.selectedAddress != null)
                AddressWidget(
                  screenSize: screenSize,
                  address: checkoutLogic.address,
                  onPressed: _selectAddress,
                ),
              PaymentMethodCard(
                selectedPaymentMethod: checkoutLogic.selectedPaymentMethod,
                onChanged: (newValue) {
                  setState(() {
                    checkoutLogic.updateSelectedPaymentMethod(newValue!);
                    if (checkoutLogic.selectedPaymentMethod == 'Оплата картой') {
                      _selectPaymentMethod();
                    }
                  });
                },
              ),
              if (checkoutLogic.selectedPaymentMethod == 'Оплата картой' && checkoutLogic.selectedCard != null)
                ListTile(
                  title: Text('Карта: ${checkoutLogic.selectedCard!.cardNumber}'),
                  subtitle: Text('Срок действия: ${checkoutLogic.selectedCard!.cardExpiry}'),
                  leading: const Icon(Icons.credit_card),
                ),
              OrderSummary(
                totalPrice: checkoutLogic.totalPrice,
                selectedDeliveryMethod: checkoutLogic.selectedDeliveryMethod,
                onOrder: () {
                  if(checkoutLogic.selectedPaymentMethod == 'Оплата картой' || checkoutLogic.selectedPaymentMethod == 'Наличными' && checkoutLogic.selectedDeliveryMethod=="Доставка курьером"||checkoutLogic.selectedDeliveryMethod=="Самовызов") {
                    checkoutLogic.placeOrder(widget.basketItems);
                  }
                  else{
                    
                  }
                },
              ),
            ],
          ),
          if (checkoutLogic.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
