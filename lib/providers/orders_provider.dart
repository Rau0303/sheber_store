import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheber_market/models/order.dart' as app_order;
import 'package:sheber_market/models/basket_item.dart';

class OrdersProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<app_order.Order> _orders = [];
  List<app_order.Order> get orders => _orders;

  Future<void> loadOrders() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Загружаем заказы из Firebase
    final snapshot = await _firestore
        .collection('orders')
        .where('user_id', isEqualTo: userId)
        .get();

    final firebaseOrders = snapshot.docs.map((doc) async {
      final data = doc.data();

      // Загружаем продукты для каждого заказа
      final productsSnapshot = await _firestore
          .collection('order_products')
          .where('order_id', isEqualTo: doc.id)
          .get();

      final orderedProducts = productsSnapshot.docs.map((productDoc) {
        return BasketItem.fromJson(productDoc.data());
      }).toList();

      return app_order.Order.fromMap({
        ...data,
        'id': doc.id,
        'ordered_products': orderedProducts, // Добавляем продукты в заказ
      });
    }).toList();

    _orders = await Future.wait(firebaseOrders); // Ожидаем загрузку всех заказов
    notifyListeners();
  }

  Future<void> addOrder(app_order.Order order) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Сохраняем заказ в Firebase и получаем его идентификатор
    final orderRef = await _firestore.collection('orders').add({
      ...order.toMap(),
      'user_id': userId,
      'order_date': Timestamp.now(),
    });

    final orderId = orderRef.id;

    // Обновляем заказ с добавленным идентификатором
    final updatedOrder = order.copyWith(id: orderId);

    // Сохраняем продукты заказа в Firebase
    for (final item in order.orderedProducts) {
      await _firestore.collection('order_products').add({
        ...item.toJson(),
        'order_id': orderId,
      });
    }

    // Обновляем заказ в Firebase с правильным идентификатором
    await _firestore.collection('orders').doc(orderId).update(updatedOrder.toMap());

    // Обновляем список заказов
    _orders.add(updatedOrder);
    notifyListeners();
  }

  Future<void> updateOrder(app_order.Order order) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Обновляем заказ в Firebase
    await _firestore.collection('orders').doc(order.id).update({
      ...order.toMap(),
    });

    // Обновляем продукты заказа
    final productsSnapshot = await _firestore
        .collection('order_products')
        .where('order_id', isEqualTo: order.id)
        .get();

    for (final doc in productsSnapshot.docs) {
      await doc.reference.delete();
    }

    for (final item in order.orderedProducts) {
      await _firestore.collection('order_products').add({
        ...item.toJson(),
        'order_id': order.id,
      });
    }

    // Обновляем список заказов
    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      _orders[index] = order;
      notifyListeners();
    }
  }

  Future<void> deleteOrder(String orderId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Удаляем заказ из Firebase
    await _firestore.collection('orders').doc(orderId).delete();

    // Удаляем продукты заказа из Firebase
    final productsSnapshot = await _firestore
        .collection('order_products')
        .where('order_id', isEqualTo: orderId)
        .get();

    for (final doc in productsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Обновляем список заказов
    _orders.removeWhere((o) => o.id == orderId);
    notifyListeners();
  }
}
