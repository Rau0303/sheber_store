import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/order.dart';
import 'package:sheber_market/providers/orders_provider.dart';

class UserOrdersLogic extends ChangeNotifier {
  
  List<Order> orders = [];

  

  Future<void> loadUserOrders(BuildContext context) async {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    await ordersProvider.loadOrders();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    orders = ordersProvider.orders.where((order) => order.userId == userId).toList();
    notifyListeners();
  }
}
