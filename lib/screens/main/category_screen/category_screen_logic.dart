import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/providers/category_provider.dart';

class CategoryScreenLogic extends ChangeNotifier {
  bool isLoading = false;
  bool isSearch = false;

  final TextEditingController searchController = TextEditingController();
  List<Category> categories = [];
  

  CategoryScreenLogic() {
    loadCategories();
  }

  List<Category> get filteredCategories {
    if (searchController.text.isEmpty) {
      return categories;
    } else {
      return categories.where((category) {
        return category.name.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }
  }

  Future<void> loadCategories() async {
    isLoading = true;
    notifyListeners();

    final api = CategoryProvider();
    await api.refreshCategories();
    categories.addAll(api.categories);

    isLoading = false;
    notifyListeners();
  }



  void toggleSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }

  void onSearchChanged(String value) {
    notifyListeners();
  }

  void onClearSearch() {
    searchController.clear();
    notifyListeners();
  }
}
