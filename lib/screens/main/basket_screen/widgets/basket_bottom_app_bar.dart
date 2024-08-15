import 'package:flutter/material.dart';

class BasketBottomAppBar extends StatelessWidget {
  final int totalQuantity;
  final double totalPrice;
  final bool isEligibleForFreeDelivery;
  final double remainingAmountForFreeDelivery;
  final VoidCallback onProceedToCheckout;

  const BasketBottomAppBar({
    super.key,
    required this.totalQuantity,
    required this.totalPrice,
    required this.isEligibleForFreeDelivery,
    required this.remainingAmountForFreeDelivery,
    required this.onProceedToCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.21,
        color: Colors.grey.shade700,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text('Товары: $totalQuantity')),
                  Flexible(child: Text('Общая сумма товаров: $totalPrice тг')),
                ],
              ),
              const SizedBox(height: 8.0),
              if (!isEligibleForFreeDelivery)
                Text(
                  'Добавьте товаров на ${remainingAmountForFreeDelivery.toInt()} тг для бесплатной доставки',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: onProceedToCheckout,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text(
                    'Оформить заказ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
