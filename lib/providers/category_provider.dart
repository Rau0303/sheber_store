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
    syncCategories();
  }

  Future<void> syncCategories() async {
    // Fetch categories from Firebase Firestore
    QuerySnapshot querySnapshot = await _firestore.collection('categories').get();
    List<Category> fetchedCategories = querySnapshot.docs.map((doc) {
      return Category.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    // Insert fetched categories into SQLite
    for (var category in fetchedCategories) {
      await _dbHelper.insertCategory(category);
    }

    // Load categories from SQLite
    await loadCategories();
  }

  Future<void> loadCategories() async {
    _categories.clear();
    List<Category> dbCategories = await _dbHelper.queryAllCategories();
    _categories.addAll(dbCategories);
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    // Add category to Firestore
    await _firestore.collection('categories').doc(category.id.toString()).set(category.toMap());
    // Add category to SQLite
    await _dbHelper.insertCategory(category);
    // Load categories from SQLite
    await loadCategories();
  }

  Future<void> deleteCategory(int id) async {
    // Delete category from Firestore
    await _firestore.collection('categories').doc(id.toString()).delete();
    // Delete category from SQLite
    await _dbHelper.deleteCategory(id);
    // Load categories from SQLite
    await loadCategories();
  }
}
