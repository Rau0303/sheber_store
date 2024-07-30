import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/providers/database_helper.dart';

class CategoryScreenLogic extends ChangeNotifier {
  bool isLoading = false;
  bool isSearch = false;

  final TextEditingController searchController = TextEditingController();
  List<Category> categories = [
        Category(id: 1, name: 'Электроника', photoUrl: 'https://example.com/electronics.png'),
    Category(id: 2, name: 'Одежда', photoUrl: 'https://example.com/clothing.png'),
    Category(id: 3, name: 'Книги', photoUrl: 'https://example.com/books.png'),
    Category(id: 4, name: 'Дом и сад', photoUrl: 'https://example.com/home_and_garden.png'),
    Category(id: 5, name: 'Спорт', photoUrl: 'https://example.com/sports.png'),
  ];
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
    addTestCategories();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await databaseHelper.insertCategory(category);
    await loadCategories();
  }
  void addTestCategories() async {
  final databaseHelper = DatabaseHelper.instance;

  List<Category> testCategories = [
    Category(id: 1, name: 'Электроника', photoUrl: 'https://blog.fenix.help/common/upload/ckeditor/2020/05/04/c26815-yelektronika-1588570887.jpg'),
    Category(id: 2, name: 'Одежда', photoUrl: 'https://blog.fenix.help/common/upload/ckeditor/2020/05/04/c26815-yelektronika-1588570887.jpg'),
    Category(id: 3, name: 'Книги', photoUrl: 'https://blog.fenix.help/common/upload/ckeditor/2020/05/04/c26815-yelektronika-1588570887.jpg'),
    Category(id: 4, name: 'Дом и сад', photoUrl: 'https://blog.fenix.help/common/upload/ckeditor/2020/05/04/c26815-yelektronika-1588570887.jpg'),
    Category(id: 5, name: 'Спорт', photoUrl: 'https://blog.fenix.help/common/upload/ckeditor/2020/05/04/c26815-yelektronika-1588570887.jpg'),
  ];

  for (var category in testCategories) {
    await databaseHelper.insertCategory(category);
  }
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
