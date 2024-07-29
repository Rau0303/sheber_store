import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/cart_item.dart';
import 'package:sheber_market/providers/database_helper.dart';

class CartProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  Future<void> addCartItem(CartItem cartItem) async {
    try {
      // Добавить элемент в локальную базу данных
      await _dbHelper.insertCartItem(cartItem);

      // Добавить элемент в Firestore
      await _firestore.collection('cart').doc(cartItem.productId.toString()).set({
        'product_id': cartItem.productId,
        'quantity': cartItem.quantity,
      });

      _cartItems.add(cartItem);
      notifyListeners();
    } catch (e) {
      print("Ошибка при добавлении элемента в корзину: $e");
    }
  }

  Future<void> fetchCartItems() async {
    try {
      // Получить все элементы корзины из локальной базы данных
      _cartItems = await _dbHelper.queryAllCartItems();
      notifyListeners();
    } catch (e) {
      print("Ошибка при получении элементов корзины: $e");
    }
  }

  Future<void> deleteCartItem(int productId) async {
    try {
      // Удалить элемент из локальной базы данных
      await _dbHelper.deleteCartItem(productId);

      // Удалить элемент из Firestore
      await _firestore.collection('cart').doc(productId.toString()).delete();

      _cartItems.removeWhere((item) => item.productId == productId);
      notifyListeners();
    } catch (e) {
      print("Ошибка при удалении элемента из корзины: $e");
    }
  }

  Future<void> clearCart() async {
    try {
      // Удалить все элементы из локальной базы данных
      await _dbHelper.clearCartItems();

      // Удалить все элементы из Firestore
      var batch = _firestore.batch();
      var cartItemsCollection = _firestore.collection('cart');
      var cartItemsSnapshot = await cartItemsCollection.get();
      for (var doc in cartItemsSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      _cartItems.clear();
      notifyListeners();
    } catch (e) {
      print("Ошибка при очистке корзины: $e");
    }
  }

  Future<void> syncCartItemsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('cart').get();
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['product_id'] != null && data['quantity'] != null) {
          CartItem cartItem = CartItem(
            productId: data['product_id'],
            quantity: data['quantity'],
          );
          await _dbHelper.insertCartItem(cartItem);
        }
      }
      await fetchCartItems();
    } catch (e) {
      print("Ошибка при синхронизации элементов корзины: $e");
    }
  }
}
