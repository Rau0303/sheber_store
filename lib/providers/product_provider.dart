// lib/providers/product_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/database_helper.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> addProduct(Product product) async {
    try {
      // Добавить товар в локальную базу данных
      await _dbHelper.insertProduct(product);

      _products.add(product);
      notifyListeners();
    } catch (e) {
      print("Ошибка при добавлении товара: $e");
    }
  }

  Future<void> fetchProductsFromLocal() async {
    try {
      _products = await _dbHelper.queryAllProducts();
      notifyListeners();
    } catch (e) {
      print("Ошибка при получении товаров из локальной базы данных: $e");
    }
  }

  Future<void> syncProductsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      for (var doc in snapshot.docs) {
        Product product = Product.fromMap(doc.data() as Map<String, dynamic>);
        await _dbHelper.insertProduct(product);
      }
      await fetchProductsFromLocal();
    } catch (e) {
      print("Ошибка при синхронизации товаров: $e");
    }
  }
}
