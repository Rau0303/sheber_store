// lib/providers/user_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/users.dart';
import 'package:sheber_market/providers/database_helper.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> addUser(User user) async {
    try {
      await _dbHelper.insertUser(user);
      await _firestore.collection('users').doc(user.id.toString()).set(user.toMap());
      await fetchUsersFromLocal(); // Refresh the local users list after adding
    } catch (e) {
      print("Ошибка при добавлении пользователя: $e");
    }
  }

  Future<void> fetchUsersFromLocal() async {
    try {
      _users = await _dbHelper.queryAllUsers();
      notifyListeners();
    } catch (e) {
      print("Ошибка при получении пользователей из локальной базы данных: $e");
    }
  }

  Future<void> syncUsersFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      for (var doc in snapshot.docs) {
        User user = User.fromMap(doc.data() as Map<String, dynamic>);
        await _dbHelper.insertUser(user);
      }
      await fetchUsersFromLocal();
    } catch (e) {
      print("Ошибка при синхронизации пользователей: $e");
    }
  }
}
