import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheber_market/models/order.dart'as app_order;
import 'package:sheber_market/models/order_product.dart';
import 'package:sheber_market/providers/database_helper.dart';



class OrdersProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<app_order.Order> _orders = [];
  List<app_order.Order> get orders => _orders;

  Future<void> loadOrders() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Загружаем заказы из локальной базы данных
    _orders = await _dbHelper.queryOrdersByUserId(userId);
    notifyListeners();

    // Загружаем заказы из Firebase
    final snapshot = await _firestore
        .collection('orders')
        .where('user_id', isEqualTo: userId)
        .get();

    final firebaseOrders = snapshot.docs.map((doc) => app_order.Order.fromMap(doc.data())).toList();

    // Сохраняем заказы в локальной базе данных
    for (final order in firebaseOrders) {
      await _dbHelper.insertOrder(order);
    }

    // Обновляем список заказов
    _orders.addAll(firebaseOrders);
    notifyListeners();
  }

  Future<void> addOrder(app_order.Order order, List<OrderProduct> orderProducts) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Сохраняем заказ в локальной базе данных
    await _dbHelper.insertOrder(order);

    // Сохраняем продукты заказа в локальной базе данных
    for (final orderProduct in orderProducts) {
      await _dbHelper.insertOrderProduct(orderProduct);
    }

    // Сохраняем заказ в Firebase
    await _firestore.collection('orders').add(order.toMap());
    for (final orderProduct in orderProducts) {
      await _firestore.collection('order_products').add(orderProduct.toMap());
    }

    // Обновляем список заказов
    _orders.add(order);
    notifyListeners();
  }

  Future<void> updateOrder(app_order.Order order) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Обновляем заказ в локальной базе данных
    await _dbHelper.updateOrder(order);

    // Находим идентификатор документа в Firestore
    final snapshot = await _firestore
        .collection('orders')
        .where('user_id', isEqualTo: userId)
        .get();
    final docId = snapshot.docs.first.id;
    
    // Обновляем заказ в Firebase
    await _firestore.collection('orders').doc(docId).update(order.toMap());

    // Обновляем список заказов
    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      _orders[index] = order;
      notifyListeners();
    }
  }

  Future<void> deleteOrder(int orderId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Удаляем заказ из локальной базы данных
    await _dbHelper.deleteOrder(orderId);

    // Удаляем продукты заказа из локальной базы данных
    await _dbHelper.deleteOrderProducts(orderId);

    // Находим иденфикатор документа в Firestore
    final snapshot = await _firestore
        .collection('orders')
        .where('user_id', isEqualTo: userId)
        .get();
    final docId = snapshot.docs.first.id;
    
    // Удаляем заказ из Firebase
    await _firestore.collection('orders').doc(docId).delete();

    // Обновляем список заказов
    _orders.removeWhere((o) => o.id == orderId);
    notifyListeners();
  }
}
