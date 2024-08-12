import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> products = [];



Future<void> fetchProductsFromFirebase() async {
  try {
    QuerySnapshot snapshot = await _firestore.collection('products').get();

    products.clear();
    for (var doc in snapshot.docs) {
      print("Полученные данные из Firebase: ${doc.data()}");

      try {
        Product product = Product.fromMap(doc.data() as Map<String, dynamic>);
        products.add(product);
      } catch (e) {
        print("Ошибка преобразования данных: $e");
      }
    }

    notifyListeners();
  } catch (e) {
    print("Ошибка при получении товаров из Firebase: $e");
  }
}


  Future<void> syncProductsFromFirebase() async {
    try {
      await fetchProductsFromFirebase();
    } catch (e) {
      print("Ошибка при синхронизации товаров: $e");
    }
  }
}
