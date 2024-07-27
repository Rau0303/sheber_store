

import 'package:sheber_market/models/order.dart';

class UserOrdersLogic {
  final String userId;
  List<Order> orders = [];

  UserOrdersLogic({required this.userId});

  Future<void> loadUserOrders() async {
    // Получаем заказы и сортируем по дате заказа
    //orders = await OrderService().getUserOrders(userId);
    orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
  }
}
