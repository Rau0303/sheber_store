import 'package:flutter/material.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/screens/main/product_screen/product_inform_screen/product_inform_screen_logic.dart';
import 'package:sheber_market/screens/main/product_screen/product_inform_screen/widgets/product_actions.dart';
import 'package:sheber_market/screens/main/product_screen/product_inform_screen/widgets/product_details.dart';
import 'package:sheber_market/screens/main/product_screen/product_inform_screen/widgets/product_image_slider.dart';

class ProductInformScreen extends StatefulWidget {
  const ProductInformScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductInformScreen> createState() => _ProductInformScreenState();
}

class _ProductInformScreenState extends State<ProductInformScreen> {
  late ProductInformLogic _logic;
  final Set<int> _favoriteProductIds = {}; // Хранит ID избранных продуктов
  final List<Product> _basket = []; // Хранит продукты в корзине

  @override
  void initState() {
    super.initState();
    _logic = ProductInformLogic();
  }

  void _onFavoriteToggled(int productId) {
    setState(() {});
  }

  void _onProductAdded() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = _favoriteProductIds.contains(widget.product.id);
    final List<String> photoUrls = widget.product.photo != null
        ? [widget.product.photo!] // Преобразуем строку в список строк
        : []; // Если нет фото, создаем пустой список

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView(
        children: [
          ProductImageSlider(photoUrls: photoUrls),
          ProductDetails(product: widget.product),
        ],
      ),
      bottomNavigationBar: ProductActions(
        product: widget.product,
        isFavorite: isFavorite,
        onAddToBasket: () => _logic.addToBasket(context, widget.product, _basket, _onProductAdded),
        onToggleFavorite: () => _logic.toggleFavorite(widget.product, _favoriteProductIds, _onFavoriteToggled),
      ),
    );
  }
}
