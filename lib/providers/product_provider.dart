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
      // Получаем данные из Firebase
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      
      // Очистка таблицы продуктов перед обновлением
      await _dbHelper.clearProducts();

      for (var doc in snapshot.docs) {
        print("Полученные данные из Firebase: ${doc.data()}");

        Product product = Product.fromMap(doc.data() as Map<String, dynamic>);

        print("Десериализованный объект Product: $product");

        await _dbHelper.insertProduct(product);
      }

      // Обновляем список продуктов из локальной базы данных
      await fetchProductsFromLocal();
    } catch (e) {
      print("Ошибка при синхронизации товаров: $e");
    }
  }
}
