import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/models/product.dart';

class HomeScreenLogic extends ChangeNotifier {
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  List<Category> categories = [];
  List<Product> products = [];

  // Фильтрация категорий в зависимости от поиска
  List<Category> get filteredCategories {
    if (isSearch) {
      return categories.where((category) {
        return category.name.toLowerCase().contains(
              searchController.text.toLowerCase(),
            );
      }).toList();
    }
    return categories;
  }

  // Загрузка категорий и продуктов
  void init() {
    categories = loadCategories();
    products = loadProducts();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged(String value) {
    notifyListeners();
  }

  void onSearchPressed() {
    isSearch = true;
    notifyListeners();
  }

  void onClearPressed() {
    searchController.clear();
    isSearch = false;
    notifyListeners();
  }

  // Загрузка категорий (здесь замените на свою логику)
  List<Category> loadCategories() {
    return [
      Category(id: 1, name: 'Electronics', photoUrl: 'https://example.com/electronics.jpg'),
      Category(id: 2, name: 'Fashion', photoUrl: 'https://example.com/fashion.jpg'),
    ];
  }

  // Загрузка продуктов (здесь замените на свою логику)
  List<Product> loadProducts() {
    return [
      Product(id: 1, name: 'Smartphone', sellingPrice: 299.99, quantity: 10, photo: 'https://example.com/smartphone.jpg', barcode: '', category: '', unit: ''),
      Product(id: 2, name: 'Laptop', sellingPrice: 899.99, quantity: 5, photo: 'https://example.com/laptop.jpg', barcode: '', category: '', unit: ''),
    ];
  }
  bool isFavorite(int id){
      return false;
  }
}
