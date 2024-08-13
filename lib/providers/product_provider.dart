import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> products = [];

  Future<void> _fetchProductsFromFirebase() async {
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
      notifyListeners(); // Добавлено для обновления состояния после загрузки
    } catch (e) {
      print("Ошибка при получении товаров из Firebase: $e");
    }
  }

  Future<void> syncProductsFromFirebase() async {
    try {
      await _fetchProductsFromFirebase();
    } catch (e) {
      print("Ошибка при синхронизации товаров: $e");
    }
  }

  // Новый метод для получения продуктов по их ID
Future<List<Product>> fetchProductsByIds(List<int> productIds) async {
  try {
    final productSnapshots = await Future.wait(
      productIds.map((id) => _firestore.collection('products').where('id', isEqualTo: id).get())
    );

    // Логирование ID документов и их статуса
    for (var snapshot in productSnapshots) {
      if (snapshot.docs.isNotEmpty) {
        
      } else {
        
      }
    }

    // Обрабатываем данные
    return productSnapshots.expand((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>);
      });
    }).toList();
  } catch (e) {
    print("Ошибка при получении продуктов по ID: $e");
    return []; // Возвращаем пустой список в случае ошибки
  }
}




}
