import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  String? get _userId => _auth.currentUser?.uid;

  Future<void> addCartItem(CartItem cartItem) async {
    final userId = _userId;
    if (userId == null) return;

    try {
      // Добавить элемент в Firestore
      await _firestore.collection('users').doc(userId).collection('cart').doc(cartItem.productId.toString()).set({
        'product_id': cartItem.productId,
        'quantity': cartItem.quantity,
      });

      // Обновляем локальное состояние корзины
      _cartItems.add(cartItem);
      notifyListeners();
    } catch (e) {
      print("Ошибка при добавлении элемента в корзину: $e");
    }
  }

  Future<void> fetchCartItems() async {
    final userId = _userId;
    if (userId == null) return;

    try {
      // Получить все элементы корзины из Firestore
      var cartItemsSnapshot = await _firestore.collection('users').doc(userId).collection('cart').get();
      _cartItems = cartItemsSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return CartItem.fromMap(data);
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Ошибка при получении элементов корзины: $e");
    }
  }

  Future<void> deleteCartItem(int productId) async {
    final userId = _userId;
    if (userId == null) return;

    try {
      // Удалить элемент из Firestore
      await _firestore.collection('users').doc(userId).collection('cart').doc(productId.toString()).delete();

      // Обновляем локальное состояние корзины
      _cartItems.removeWhere((item) => item.productId == productId);
      notifyListeners();
    } catch (e) {
      print("Ошибка при удалении элемента из корзины: $e");
    }
  }

  Future<void> clearCart() async {
    final userId = _userId;
    if (userId == null) return;

    try {
      // Удалить все элементы из Firestore
      var batch = _firestore.batch();
      var cartItemsCollection = _firestore.collection('users').doc(userId).collection('cart');
      var cartItemsSnapshot = await cartItemsCollection.get();
      for (var doc in cartItemsSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      // Очистить локальное состояние корзины
      _cartItems.clear();
      notifyListeners();
    } catch (e) {
      print("Ошибка при очистке корзины: $e");
    }
  }

  Future<void> syncCartItemsFromFirebase() async {
    await fetchCartItems(); // Убедитесь, что корзина синхронизирована
  }
}
