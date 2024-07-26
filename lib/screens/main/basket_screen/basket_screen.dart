import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen_logic.dart';
import 'package:sheber_market/screens/main/basket_screen/widgets/basket_bottom_app_bar.dart';
import 'package:sheber_market/screens/main/basket_screen/widgets/basket_item.dart';
import 'package:sheber_market/widgets/enhanced_app_bar.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  BasketScreenState createState() => BasketScreenState();
}

class BasketScreenState extends State<BasketScreen> {
  late BasketLogic _logic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _logic = Provider.of<BasketLogic>(context);
  }

  @override
  Widget build(BuildContext context) {
    final basket = _logic.basket;

    int totalQuantity = _logic.calculateTotalQuantity(basket);
    double totalPrice = _logic.calculateTotalPrice(basket);
    double remainingAmountForFreeDelivery = _logic.calculateRemainingAmountForFreeDelivery(totalPrice, 50000);
    bool isEligibleForFreeDelivery = _logic.isEligibleForFreeDelivery(totalPrice, 50000);

    return Scaffold(
      appBar: EnhancedAppBar(
        title: 'Корзина',
        showAction: basket.isNotEmpty,
        onActionPressed: () {
          if (basket.isNotEmpty) {
            _logic.showClearBasketDialog(context);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: basket.isNotEmpty
            ? ListView.builder(
                itemCount: basket.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasketItemWidget(
                      item: basket[index],
                      onAdd: () => _logic.addProduct(basket[index], 1),
                      onRemove: () => _logic.removeProduct(basket[index]),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('Корзина пустая'),
              ),
      ),
      bottomNavigationBar: basket.isNotEmpty
          ? BasketBottomAppBar(
              totalQuantity: totalQuantity,
              totalPrice: totalPrice,
              isEligibleForFreeDelivery: isEligibleForFreeDelivery,
              remainingAmountForFreeDelivery: remainingAmountForFreeDelivery,
              onProceedToCheckout: () => _logic.proceedToCheckout(context),
            )
          : const SizedBox.shrink(),
    );
  }
}
