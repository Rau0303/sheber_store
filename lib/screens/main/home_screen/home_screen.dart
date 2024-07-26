import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/screens/main/home_screen/home_screen_logic.dart';
import 'package:sheber_market/screens/main/home_screen/widgets/category_card.dart';
import 'package:sheber_market/theme/adaptive_theme.dart';
import 'package:sheber_market/widgets/searchable_app_bar.dart';
import 'package:vibration/vibration.dart';
import 'package:sheber_market/screens/main/home_screen/widgets/product_gridview_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<HomeScreenLogic>(context);
    final screenSize = MediaQuery.of(context).size;
    final theme = AdaptiveTheme.getTheme(context); // Использование вашего кастомного ThemeData

    return Scaffold(
      appBar: SearchableAppBar(
        isSearch: logic.isSearch,
        searchController: logic.searchController,
        onSearchChanged: logic.onSearchChanged,
        onSearchPressed: logic.onSearchPressed,
        onClearPressed: logic.onClearPressed,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Категории', // Добавлено текстовое обозначение для категорий
              style: theme.textTheme.headlineLarge,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.2,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 1.0,
                mainAxisExtent: screenSize.width * 0.4,
              ),
              itemCount: logic.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: logic.categories[index],
                  onTap: () {
                    Vibration.vibrate(duration: 50);
                    // Handle category tap
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Товары', // Добавлено текстовое обозначение для товаров
              style: theme.textTheme.headlineLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenSize.width < 600
                    ? 2
                    : screenSize.width < 900
                        ? 3
                        : 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: logic.products.length,
              itemBuilder: (context, index) {
                final product = logic.products[index];
                return ProductGridviewCard(
                  product: product,
                  onAddToCart: () {
                    // Implement your add to cart logic
                  },
                  onToggleFavorite: () {
                    // Implement your toggle favorite logic
                  },
                  isFavorite: logic.isFavorite(product.id), // Использование метода для проверки избранного
                  onTap: () {
                    Vibration.vibrate(duration: 50);
                    Navigator.pushNamed(
                      context,
                      '/product_info',
                      arguments: product,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
