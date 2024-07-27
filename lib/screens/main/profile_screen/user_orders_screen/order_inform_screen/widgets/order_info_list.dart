import 'package:flutter/material.dart';
import 'package:sheber_market/models/order.dart';

class OrderInfoList extends StatelessWidget {
  final List<String> priceLabels; // Изменил название на более описательное
  final int deliverySumm;
  final double sum;
  final Order? order;

  const OrderInfoList({
    super.key,
    required this.priceLabels,
    required this.deliverySumm,
    required this.sum,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: priceLabels.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        String value;
        switch (priceLabels[index]) {
          case 'Доставка':
            value = '${deliverySumm.toString()} \u20B8';
            break;
          case 'Сумма':
            value = '${sum.toStringAsFixed(2)} \u20B8';
            break;
          case 'Оплачено':
            value = '${order?.totalPrice.toStringAsFixed(2)} \u20B8';
            break;
          default:
            value = "Ошибка";
        }
        return ListTile(
          title: Text(priceLabels[index]),
          trailing: Text(
            value,
            style: textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
