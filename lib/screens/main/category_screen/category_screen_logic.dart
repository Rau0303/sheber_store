import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';

class CategoryScreenLogic extends ChangeNotifier {
  bool isLoading = false;
  bool isSearch = false;

  final TextEditingController searchController = TextEditingController();
  List<Category> categories = [
    // Example categories
    // Category(name: 'Category 1', photoUrl: 'path/to/image1'),
    // Category(name: 'Category 2', photoUrl: 'path/to/image2'),
  ];

  List<Category> get filteredCategories {
    if (searchController.text.isEmpty) {
      return categories;
    } else {
      return categories.where((category) {
        return category.name.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    }
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
