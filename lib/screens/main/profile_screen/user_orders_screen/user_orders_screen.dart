import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/screens/main/profile_screen/user_orders_screen/user_orders_screen_logic.dart';

class UserOrdersScreen extends StatefulWidget {
  final String userId;

  const UserOrdersScreen({super.key, required this.userId});

  @override
  _UserOrdersScreenState createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  late UserOrdersLogic logic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logic = Provider.of<UserOrdersLogic>(context);
    logic.loadUserOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заказы'),
      ),
      body: Consumer<UserOrdersLogic>(
        builder: (context, logic, child) {
          return logic.orders.isEmpty
              ? const Center(child: Text('Заказы отсутствуют.'))
              : ListView.builder(
                  itemCount: logic.orders.length,
                  itemBuilder: (context, index) {
                    final order = logic.orders[index];
                    return ListTile(
                      title: Text('Заказ №${order.id}'),
                      subtitle: Text('Дата: ${order.orderDate}'),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/order_inform',
                          arguments: {'orderId': order.id},
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
