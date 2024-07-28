import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/models/favorite_item.dart';
import 'package:sheber_market/providers/favorite_provider.dart';

class HomeScreenLogic extends ChangeNotifier {
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  List<Category> categories = [];
  List<Product> products = [];
  List<FavoriteItem> favoriteItems = [];

  // Подключение провайдера избранного
  FavoriteProvider favoriteProvider;

  HomeScreenLogic(this.favoriteProvider) {
    init();
  }

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
    loadFavoriteItems();
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

  Future<void> loadFavoriteItems() async {
    favoriteItems = await favoriteProvider.fetchFavoriteItems();
    notifyListeners();
  }

  Future<void> toggleFavorite(int productId) async {
    if (isFavorite(productId)) {
      await favoriteProvider.deleteFavoriteItem(productId);
    } else {
      await favoriteProvider.addFavoriteItem(FavoriteItem(productId: productId));
    }
    await loadFavoriteItems();
  }

  bool isFavorite(int productId) {
    return favoriteItems.any((item) => item.productId == productId);
  }
}
