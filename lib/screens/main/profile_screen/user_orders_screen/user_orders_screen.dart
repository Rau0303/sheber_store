import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/user_orders_screen/user_orders_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/user_orders_screen/widgets/orders_listview.dart'; // Импортируем новый виджет

class UserOrdersScreen extends StatefulWidget {
  final String userId;

  const UserOrdersScreen({super.key, required this.userId});

  @override
  UserOrdersScreenState createState() => UserOrdersScreenState();
}

class UserOrdersScreenState extends State<UserOrdersScreen> {
  late final UserOrdersLogic _controller;

  @override
  void initState() {
    super.initState();
    _controller = UserOrdersLogic(userId: widget.userId);
    _controller.loadUserOrders(); // Можно использовать FutureBuilder в build, но для лучшего управления состоянием можно сделать это здесь
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заказы'),
      ),
      body: FutureBuilder<void>(
        future: _controller.loadUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки данных: ${snapshot.error}'));
          }

          return OrdersListView(orders: _controller.orders);
        },
      ),
    );
  }
}
