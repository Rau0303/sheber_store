import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';

class ProductScreenLogic {
  final BuildContext context;
  ProductScreenLogic(this.context);

  bool isLoading = false;
  bool isSearch = false;
  List<Product> filteredProducts = [];
  List<Product> categoryProducts = [];

  void fetchProducts() async {
    isLoading = true;
    _updateState();
    
    // Имитация загрузки продуктов
    await Future.delayed(const Duration(seconds: 2));
    
    // Примерные данные для имитации
    categoryProducts = [
      Product(
        id: 1,
        barcode: '1234567890',
        name: 'Продукт 1',
        sellingPrice: 100,
        category: 'Category 1',
        unit: 'шт',
        quantity: 10,
        supplier: 'Supplier 1',
        description: 'Описание продукта 1',
        photo: 'https://via.placeholder.com/150',
      ),
      Product(
        id: 2,
        barcode: '0987654321',
        name: 'Продукт 2',
        sellingPrice: 200,
        category: 'Category 2',
        unit: 'шт',
        quantity: 5,
        supplier: 'Supplier 2',
        description: 'Описание продукта 2',
        photo: 'https://via.placeholder.com/150',
      ),
    ];
    
    isLoading = false;
    _updateState();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = [];
    } else {
      filteredProducts = categoryProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    _updateState();
  }

  void _updateState() {
    //var setState = (context as StatefulElement).setState(() {});
  }
}
