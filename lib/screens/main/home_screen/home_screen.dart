import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/providers/cart_provider.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen_logic.dart';
import 'package:sheber_market/screens/main/home_screen/widgets/category_card.dart';
import 'package:sheber_market/widgets/searchable_app_bar.dart';
import 'package:vibration/vibration.dart';
import 'package:sheber_market/screens/main/home_screen/widgets/product_gridview_card.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false);
    Provider.of<HomeScreenLogic>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CartProvider>(context);
    return Consumer<HomeScreenLogic>(
      builder: (context, logic, child) {
        final screenSize = MediaQuery.of(context).size;
        final theme = Theme.of(context);

        return Scaffold(
          appBar: SearchableAppBar(
            isSearch: logic.isSearch,
            searchController: logic.searchController,
            onSearchChanged: logic.onSearchChanged,
            onSearchPressed: logic.onSearchPressed,
            onClearPressed: logic.onClearPressed,
            appBarTitle: 'Главная',
          ),
          body: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              // Промо-картинка
              Container(
                height: screenSize.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/promo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Разделитель категорий
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Категории',
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              // GridView для категорий
              SizedBox(
                height: screenSize.height * 0.2,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                    mainAxisExtent: screenSize.width * 0.4,
                  ),
                  itemCount: logic.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: logic.categories[index],
                      onTap: () {
                        Vibration.vibrate(duration: 50);
                      },
                    );
                  },
                ),
              ),
              // Разделитель товаров
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Товары',
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              // GridView для товаров
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenSize.width < 600
                      ? 2
                      : screenSize.width < 900
                          ? 3
                          : 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.55,
                ),
                itemCount: logic.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = logic.filteredProducts[index];
                  return ProductGridViewCard(
                    product: product,
                    onAddToCart: () {
                      _logger.i('Adding product ${product.name} to cart');
                      logic.addToCart(product);
                    },
                    onToggleFavorite: () {
                      _logger.i('Toggling favorite for product ${product.name}');
                      logic.toggleFavorite(product.id);
                    },
                    isFavorite: logic.isFavorite(product.id),
                    onTap: () {
                      Vibration.vibrate(duration: 50);
                      Navigator.pushNamed(
                        context,
                        '/product_inform',
                        arguments: product,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
