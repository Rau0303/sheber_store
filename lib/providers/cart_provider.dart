import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
      await _firestore.collection('users').doc(userId).collection('cart').doc(cartItem.productId.toString()).set({
        'product_id': cartItem.productId,
        'quantity': cartItem.quantity,
      });

      _cartItems.add(cartItem);
      notifyListeners();
    } catch (e) {
    }
  }

  Future<void> fetchCartItems() async {
    final userId = _userId;
    if (userId == null) return;

    try {
      var cartItemsSnapshot = await _firestore.collection('users').doc(userId).collection('cart').get();
      _cartItems = cartItemsSnapshot.docs.map((doc) {
        var data = doc.data();
        return CartItem.fromMap(data);
      }).toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Ошибка при получении элементов корзины: $e");
      }
    }
  }

  Future<void> deleteCartItem(int productId) async {
    final userId = _userId;
    if (userId == null) return;

    try {
      await _firestore.collection('users').doc(userId).collection('cart').doc(productId.toString()).delete();

      _cartItems.removeWhere((item) => item.productId == productId);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Ошибка при удалении элемента из корзины: $e");
      }
    }
  }

  Future<void> clearCart() async {
    final userId = _userId;
    if (userId == null) return;

    try {
      var batch = _firestore.batch();
      var cartItemsCollection = _firestore.collection('users').doc(userId).collection('cart');
      var cartItemsSnapshot = await cartItemsCollection.get();
      for (var doc in cartItemsSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      _cartItems.clear();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Ошибка при очистке корзины: $e");
      }
    }
  }

  Future<void> syncCartItemsFromFirebase() async {
    await fetchCartItems();
  }
}
