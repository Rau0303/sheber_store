import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/providers/database_helper.dart';

class CategoryScreenLogic extends ChangeNotifier {
  bool isLoading = false;
  bool isSearch = false;

  final TextEditingController searchController = TextEditingController();
  List<Category> categories = [];
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

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

    categories = await databaseHelper.queryAllCategories();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await databaseHelper.insertCategory(category);
    await loadCategories();
  }

  Future<void> deleteCategory(int id) async {
    await databaseHelper.deleteCategory(id);
    await loadCategories();
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
