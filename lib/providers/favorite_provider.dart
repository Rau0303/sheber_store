import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/favorite_item.dart';
import 'package:sheber_market/providers/database_helper.dart';

class FavoriteProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<FavoriteItem> _favoriteItems = [];

  List<FavoriteItem> get favoriteItems => _favoriteItems;

  Future<void> addFavoriteItem(FavoriteItem favoriteItem) async {
    try {
      // Добавить элемент в избранное в локальную базу данных
      await _dbHelper.insertFavoriteItem(favoriteItem);

      // Добавить элемент в Firebase
      await _firestore.collection('favorites').doc(favoriteItem.productId.toString()).set({
        'product_id': favoriteItem.productId,
      });

      _favoriteItems.add(favoriteItem);
      notifyListeners();
    } catch (e) {
      print("Ошибка при добавлении элемента в избранное: $e");
    }
  }

  Future<List<FavoriteItem>> fetchFavoriteItems() async {
    try {
      _favoriteItems = await _dbHelper.queryAllFavoriteItems();
      notifyListeners();
      return _favoriteItems;
    } catch (e) {
      print("Ошибка при получении элементов избранного: $e");
      return [];
    }
  }

  Future<void> deleteFavoriteItem(int productId) async {
    try {
      // Удалить элемент из избранного в локальной базе данных
      await _dbHelper.deleteFavoriteItem(productId);

      // Удалить элемент из Firebase
      await _firestore.collection('favorites').doc(productId.toString()).delete();

      _favoriteItems.removeWhere((item) => item.productId == productId);
      notifyListeners();
    } catch (e) {
      print("Ошибка при удалении элемента из избранного: $e");
    }
  }

  Future<void> syncFavoriteItemsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('favorites').get();
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['product_id'] != null) {
          FavoriteItem favoriteItem = FavoriteItem(
            productId: data['product_id'],
          );
          await _dbHelper.insertFavoriteItem(favoriteItem);
        }
      }
      await fetchFavoriteItems();
    } catch (e) {
      print("Ошибка при синхронизации элементов избранного: $e");
    }
  }
}
