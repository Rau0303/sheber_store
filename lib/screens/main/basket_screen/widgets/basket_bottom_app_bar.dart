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
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness==Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          height:isEligibleForFreeDelivery? screenSize.height * 0.15 :screenSize.height * 0.255,
          color: isDarkTheme? Colors.grey.shade700 :Colors.grey.shade300,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text('Товары: $totalQuantity',style: theme.textTheme.bodyMedium?.copyWith(color:isDarkTheme?Colors.white:Colors.black,fontWeight:  FontWeight.bold),)),
                    Flexible(child: Text('Общая сумма товаров: $totalPrice тг',style: theme.textTheme.bodyLarge?.copyWith(color:isDarkTheme?Colors.white:Colors.black,fontWeight:  FontWeight.bold))),
                  ],
                ),
                const SizedBox(height: 3.0),
                if (!isEligibleForFreeDelivery)
                  Text(
                    'Добавьте товаров на ${remainingAmountForFreeDelivery.toInt()} тг для бесплатной доставки',
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 3.0),
                ElevatedButton(
                  onPressed: onProceedToCheckout,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  ),
                  child:  Text(
                    'Оформить заказ',
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
