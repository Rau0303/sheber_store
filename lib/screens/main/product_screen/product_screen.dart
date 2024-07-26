import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/product_screen/widgets/product_card.dart';
import 'package:sheber_market/widgets/searchable_app_bar.dart';
import 'product_screen_logic.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.category});
  final String category;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductScreenLogic _logic;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _logic = ProductScreenLogic(context);
    _searchController = TextEditingController();
    _logic.fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final products = _logic.isSearch ? _logic.filteredProducts : _logic.categoryProducts;

    return Scaffold(
      appBar: SearchableAppBar(
        isSearch: _logic.isSearch,
        searchController: _searchController,
        onSearchChanged: (query) {
          _logic.searchProducts(query);
          setState(() {});
        },
        onSearchPressed: () {
          setState(() {
            _logic.isSearch = true;
          });
        },
        onClearPressed: () {
          _searchController.clear();
          _logic.searchProducts('');
          setState(() {
            _logic.isSearch = false;
          });
        },
        appBarTitle: 'Товары',
      ),
      body: _logic.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.01,
                vertical: screenSize.height * 0.02,
              ),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    imageUrl: product.photo!,
                    title: product.name,
                    description: product.description!,
                    total: product.sellingPrice,
                    onTap: () {},
                    on: () {
                      // Обработайте добавление в корзину
                    },
                    product: product,
                    quantity: 0,
                  );
                },
              ),
            ),
    );
  }
}
