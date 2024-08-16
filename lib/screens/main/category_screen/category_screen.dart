import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/screens/main/category_screen/category_screen_logic.dart';
import 'package:sheber_market/screens/main/category_screen/widgets/category_tile.dart';
import 'package:sheber_market/widgets/searchable_app_bar.dart';



class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Provider.of<CategoryScreenLogic>(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: SearchableAppBar(
        isSearch: logic.isSearch,
        searchController: logic.searchController,
        onSearchChanged: (value) {
          // Handle search input changes
        },
        onSearchPressed: () {
          logic.toggleSearch();
        },
        onClearPressed: () {
          logic.searchController.clear();
          logic.toggleSearch();
        }, appBarTitle: 'Категории',
      ),
      body: logic.isSearch 
          ? const Center(child: Text('Неизвестная ошибка'))
          : 
          logic.isLoading
          ?
          const Center(child: CircularProgressIndicator(),)
          :
          Padding(
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
              child: ListView.separated(
                itemCount: logic.categories.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final category = logic.categories[index];
                  return CategoryTile(
                    category: category,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/category-products',
                        arguments: {'category': category.name},
                        );
                    },
                  );
                },
              ),
            ),
    );
  }
}
