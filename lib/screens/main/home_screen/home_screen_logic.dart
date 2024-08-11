import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/models/favorite_item.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/category_provider.dart';
import 'package:sheber_market/providers/favorite_provider.dart';
import 'package:sheber_market/providers/product_provider.dart';

class HomeScreenLogic extends ChangeNotifier {
  bool isSearch = false;
  bool isInitialized = false; // Добавьте это поле
  TextEditingController searchController = TextEditingController();
  List<FavoriteItem> favoriteItems = [];
  List<Product> cartItems = [];
  List<Product> products = [];

  final CategoryProvider categoryProvider;
  final ProductProvider productProvider;
  final FavoriteProvider favoriteProvider;

  HomeScreenLogic(
    this.favoriteProvider,
    this.categoryProvider,
    this.productProvider,
  ) {
    init();
  }

  List<Category> get filteredCategories {
    if (isSearch) {
      return categoryProvider.categories.where((category) {
        return category.name.toLowerCase().contains(
              searchController.text.toLowerCase(),
            );
      }).toList();
    }
    return categoryProvider.categories;
  }

  Future<void> init() async {
    if (!isInitialized) { // Проверьте, инициализировано ли уже
      await _loadInitialData();
      await loadFavoriteItems();
      isInitialized = true; // Установите флаг после инициализации
    }
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

  Future<void> _loadInitialData() async {
    try {
      await categoryProvider.syncCategories();
      await productProvider.syncProductsFromFirebase();
      products = productProvider.products;
      print('Products loaded: ${products.length}');
      notifyListeners();
    } catch (e) {
      print('Error loading initial data: $e');
    }
  }

  Future<void> loadFavoriteItems() async {
    try {
      favoriteItems = await favoriteProvider.fetchFavoriteItems();
      print('Favorite items loaded: ${favoriteItems.length}');
      notifyListeners();
    } catch (e) {
      print('Error loading favorite items: $e');
    }
  }

  Future<void> toggleFavorite(int productId) async {
    try {
      if (isFavorite(productId)) {
        await favoriteProvider.deleteFavoriteItem(productId);
      } else {
        await favoriteProvider.addFavoriteItem(
          FavoriteItem(productId: productId),
        );
      }
      await loadFavoriteItems();
    } catch (e) {
      print('Error toggling favorite: $e');
    }
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
