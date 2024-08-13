import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/cart_item.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/models/favorite_item.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/category_provider.dart';
import 'package:sheber_market/providers/favorite_provider.dart';
import 'package:sheber_market/providers/product_provider.dart';
import 'package:sheber_market/providers/cart_provider.dart'; // Импортируем CartProvider
import 'package:logger/logger.dart';

class HomeScreenLogic extends ChangeNotifier {
  bool isSearch = false;
  bool isInitialized = false;
  TextEditingController searchController = TextEditingController();
  List<FavoriteItem> favoriteItems = [];
  List<Product> cartItems = [];
  List<Product> products = [];
  List<Category> categories = [];
  var logger = Logger(printer: PrettyPrinter());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CartProvider _cartProvider = CartProvider(); // Добавляем CartProvider

  HomeScreenLogic(); // Передаем CartProvider через конструктор

  List<Category> get filteredCategories {
    final categoryProvider = CategoryProvider();
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
    if (!isInitialized) {
      try {
        await _loadInitialData();
        await loadFavoriteItems();
        isInitialized = true;
        notifyListeners();
      } catch (e) {
        print('Error initializing HomeScreenLogic: $e');
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged(String value) {
    searchController.text = value;
    isSearch = value.isNotEmpty;
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

  List<Product> get filteredProducts {
    if (isSearch) {
      return products.where((product) {
        return product.name.toLowerCase().contains(
              searchController.text.toLowerCase(),
            );
      }).toList();
    }
    return products;
  }

  Future<void> _loadInitialData() async {
    final categoryProvider = CategoryProvider();
    final productProvider = ProductProvider();
    try {
      await categoryProvider.refreshCategories();
      await productProvider.syncProductsFromFirebase();
      products.clear();
      categories.clear();
      products.addAll(productProvider.products);
      categories.addAll(categoryProvider.categories);
      logger.i('Products loaded: ${products.length}');
      notifyListeners();
    } catch (e) {
      print('Error loading initial data: $e');
    }
  }

  Future<void> loadFavoriteItems() async {
    final favoriteProvider = FavoriteProvider();
    final User? currentUser = _auth.currentUser;
    final currentUserId = currentUser?.uid ?? "";

    try {
      favoriteItems = await favoriteProvider.fetchFavoriteItems(currentUserId);
      print('Favorite items loaded: ${favoriteItems.length}');
      notifyListeners();
    } catch (e) {
      print('Error loading favorite items: $e');
    }
  }

  Future<void> toggleFavorite(int productId) async {
    final favoriteProvider = FavoriteProvider();
    final User? currentUser = _auth.currentUser;
    final currentUserId = currentUser?.uid ?? "";

    try {
      if (isFavorite(productId)) {
        await favoriteProvider.deleteFavoriteItem(currentUserId, productId);
      } else {
        await favoriteProvider.addFavoriteItem(
          FavoriteItem(userId: currentUserId, productId: productId),
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

  Future<void> addToCart(Product product) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    try {
      await _cartProvider.addCartItem(CartItem(
        productId: product.id,
        quantity: 1, // Вы можете использовать другое значение по умолчанию
      ));
      notifyListeners();
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
    notifyListeners();
  }
}
