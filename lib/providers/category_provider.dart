import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Category> _categories = [];

  List<Category> get categories => _categories;

  CategoryProvider() {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('categories').get();
      _categories.clear();
      _categories.addAll(querySnapshot.docs.map((doc) {
        return Category.fromMap(doc.data() as Map<String, dynamic>);
      }).toList());
      notifyListeners();
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> refreshCategories() async {
    await _loadCategories();
  }
}
