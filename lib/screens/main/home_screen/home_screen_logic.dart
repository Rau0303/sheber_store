
import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/models/favorite_item.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/favorite_provider.dart';

class HomeScreenLogic extends ChangeNotifier {
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  List<Category> categories = [];
  List<Product> products = [];
  List<FavoriteItem> favoriteItems = [];
  List<Product> cartItems = []; // Добавлено для корзины

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
      Category(id: 1, name: 'Electronics', photoUrl: 'https://qph.cf2.quoracdn.net/main-qimg-0008f7febf8957248117a8c76e7af45d-lq'),
      Category(id: 2, name: 'Fashion', photoUrl: 'https://marketplace.canva.com/EAFCbKLQ_LE/1/0/1600w/canva-white-black-minimalist-fashion-store-logo-FBKZMKJ8Vpw.jpg'),
    ];
  }

  // Загрузка продуктов (здесь замените на свою логику)
  List<Product> loadProducts() {
    return [
      Product(id: 1, name: 'Smartphone', sellingPrice: 299.99, quantity: 10, photo: 'https://www.zdnet.com/a/img/resize/9c4c6a4546bf9e283e63548c45f588360ce02607/2023/10/05/487a7516-8c27-4547-9dd5-e78f40e8d112/google-pixel-8-pro-screen.jpg?auto=webp&fit=crop&height=900&width=1200', barcode: '', category: '', unit: ''),
      Product(id: 2, name: 'Laptop', sellingPrice: 899.99, quantity: 5, photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGSY3oATUFK1siYGE9_3x9dcZpEb321Jyn7Q&s', barcode: '', category: '', unit: ''),
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

  void addToCart(Product product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
    notifyListeners();
  }
}
