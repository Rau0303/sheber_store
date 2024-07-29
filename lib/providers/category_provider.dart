import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';
import 'package:sheber_market/providers/database_helper.dart';

class CategoryProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final List<Category> _categories = [];

  List<Category> get categories => _categories;

  CategoryProvider() {
    _syncCategories();
  }

  Future<void> _syncCategories() async {
    // Listen for changes in Firestore collection
    _firestore.collection('categories').snapshots().listen((querySnapshot) async {
      List<Category> fetchedCategories = querySnapshot.docs.map((doc) {
        return Category.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      // Clear existing categories in SQLite before inserting new ones
      await _dbHelper.clearCategories();

      // Insert fetched categories into SQLite
      for (var category in fetchedCategories) {
        await _dbHelper.insertCategory(category);
      }

      // Load categories from SQLite
      await _loadCategories();
    });
  }

  Future<void> _loadCategories() async {
    _categories.clear();
    List<Category> dbCategories = await _dbHelper.queryAllCategories();
    _categories.addAll(dbCategories);
    notifyListeners();
  }
}
