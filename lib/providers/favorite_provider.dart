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
      await _dbHelper.insertFavoriteItem(favoriteItem);
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
      await _dbHelper.deleteFavoriteItem(productId);
      await _firestore.collection('favorites').doc(productId.toString()).delete();

      _favoriteItems.removeWhere((item) => item.productId == productId);
      notifyListeners();
    } catch (e) {
      print("Ошибка при удалении элемента из избранного: $e");
    }
  }
}
