import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/sql/category_helper.dart';
import 'package:sheber_market/sql/product_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class SyncManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CategoryHelper _categoryHelper = CategoryHelper();
  final ProductHelper _productHelper = ProductHelper();

  // Метод для синхронизации категорий
  Future<void> syncCategories() async {
    try {
      // Загрузка категорий из Firebase
      QuerySnapshot querySnapshot = await _firestore.collection('categories').get();
      List<Category> firebaseCategories = querySnapshot.docs.map((doc) {
        return Category.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      // Очищаем локальную базу данных и добавляем новые данные
      await _categoryHelper.clearCategories();
      for (var category in firebaseCategories) {
        // Загрузка фотографий
        if (category.photoUrl != null) {
          category = await _downloadCategoryPhoto(category);
        }
        await _categoryHelper.insertCategory(category);
      }
    } catch (e) {
      print('Error syncing categories: $e');
    }
  }

  // Метод для синхронизации продуктов
  Future<void> syncProducts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      List<Product> firebaseProducts = querySnapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      await _productHelper.clearProducts();
      for (var product in firebaseProducts) {
        if (product.photo != null) {
          product = await _downloadProductPhoto(product);
        }
        await _productHelper.insertProduct(product);
      }
    } catch (e) {
      print('Error syncing products: $e');
    }
  }

  // Метод для загрузки фото категории
  Future<Category> _downloadCategoryPhoto(Category category) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, '${category.id}_category.jpg');
    final file = File(path);

    try {
      // Загрузка фотографии
      final photoUrl = category.photoUrl;
      if (photoUrl != null) {
        final response = await http.get(Uri.parse(photoUrl));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          category = Category(
            id: category.id,
            name: category.name,
            photoUrl: path,
          );
        } else {
          print('Failed to download category photo. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error downloading category photo: $e');
    }
    return category;
  }

  // Метод для загрузки фото продукта
  Future<Product> _downloadProductPhoto(Product product) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, '${product.id}_product.jpg');
    final file = File(path);

    try {
      final photoUrl = product.photo;
      if (photoUrl != null) {
        final response = await http.get(Uri.parse(photoUrl));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          product = Product(
            id: product.id,
            barcode: product.barcode,
            name: product.name,
            sellingPrice: product.sellingPrice,
            category: product.category,
            unit: product.unit,
            quantity: product.quantity,
            supplier: product.supplier,
            description: product.description,
            photo: path,
          );
        } else {
          print('Failed to download product photo. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error downloading product photo: $e');
    }
    return product;
  }
}
