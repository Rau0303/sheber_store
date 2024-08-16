import 'package:flutter/material.dart';
import 'package:sheber_market/models/order.dart';

class OrdersListView extends StatelessWidget {
  final List<Order> orders;

  const OrdersListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orders.length,
      separatorBuilder: (context, index) => const Divider(color: Colors.grey),
      itemBuilder: (context, index) {
        Order order = orders[index];
        return ListTile(
          title: Text('Заказ №${order.id}'),
          subtitle: Text('${order.deliveryAddress ?? 'Не указано'}'),
          trailing: Text(
            '${order.totalPrice} ₸',
            style: const TextStyle(color: Color.fromARGB(255, 109, 186, 111)),
          ),
          onTap: () {
            
          },
        );
      },
    );
  }
}
