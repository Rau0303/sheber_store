import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/favorite_item.dart';

class FavoriteProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFavoriteItem(FavoriteItem favoriteItem) async {
    try {
      await _firestore.collection('users')
        .doc(favoriteItem.userId)
        .collection('favorites')
        .doc(favoriteItem.productId.toString())
        .set(favoriteItem.toMap());
      
      notifyListeners();
    } catch (e) {
      print("Ошибка при добавлении элемента в избранное: $e");
    }
  }

  Future<void> deleteFavoriteItem(String userId, int productId) async {
    try {
      await _firestore.collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId.toString())
        .delete();
      
      notifyListeners();
    } catch (e) {
      print("Ошибка при удалении элемента из избранного: $e");
    }
  }

  Future<List<FavoriteItem>> fetchFavoriteItems(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
      
      return snapshot.docs.map((doc) {
        return FavoriteItem.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Ошибка при получении элементов избранного: $e");
      return [];
    }
  }
}
