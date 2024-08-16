import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/favorite_item.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/providers/favorite_provider.dart';
import 'package:sheber_market/providers/product_provider.dart';
import 'package:sheber_market/screens/main/basket_screen/basket_screen_logic.dart';
import 'package:sheber_market/screens/main/product_screen/widgets/product_card.dart';
import 'package:sheber_market/widgets/searchable_app_bar.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key, required this.category});
  final String category;

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  late TextEditingController _searchController;
  late ProductProvider _productProvider;
  late BasketLogic _basketLogic; // Добавьте эту переменную
  bool _isSearch = false;
  List<Product> _filteredProducts = [];
  List<FavoriteItem> favoriteItems = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _basketLogic = Provider.of<BasketLogic>(context, listen: false); // Получите экземпляр BasketLogic
    _fetchCategoryProducts();
    loadFavoriteItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCategoryProducts() async {
    await _productProvider.syncProductsFromFirebase();
    _filterProducts();
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _productProvider.products
          .where((product) => product.category == widget.category)
          .toList();
    });
  }

  void _searchProducts(String query) {
    setState(() {
      _filteredProducts = _productProvider.products
          .where((product) =>
              product.category == widget.category &&
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addProductToBasket(Product product) {
    
    _basketLogic.addProduct(product, 1); // Добавьте продукт в корзину с количеством 1
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} добавлен в корзину')),
    );
  }

  Future<void> loadFavoriteItems() async {
    final favoriteProvider = FavoriteProvider();
    final User? currentUser = _auth.currentUser;
    final currentUserId = currentUser?.uid ?? "";

    try {
      favoriteItems = await favoriteProvider.fetchFavoriteItems(currentUserId);
      print('Favorite items loaded: ${favoriteItems.length}');
      setState(() {
        
      });
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: SearchableAppBar(
        isSearch: _isSearch,
        searchController: _searchController,
        onSearchChanged: (query) {
          _searchProducts(query);
        },
        onSearchPressed: () {
          setState(() {
            _isSearch = true;
          });
        },
        onClearPressed: () {
          _searchController.clear();
          _searchProducts('');
          setState(() {
            _isSearch = false;
          });
        },
        appBarTitle: 'Товары в категории: ${widget.category}',
      ),
      body: _productProvider.products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.01,
                vertical: screenSize.height * 0.02,
              ),
              child: ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return ProductCard(
                    imageUrl: product.photo ?? '',
                    title: product.name,
                    description: product.description ?? '',
                    total: product.sellingPrice,
                    onTap: () {
                      toggleFavorite(product.id);
                    },
                    on: () {
                      _addProductToBasket(product); // Обработка добавления в корзину
                    },
                    product: product,
                    quantity: product.quantity,
                  );
                },
              ),
            ),
    );
  }
}
