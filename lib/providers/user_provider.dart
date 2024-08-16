// lib/providers/user_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/users.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Users> _users = [];

  List<Users> get users => _users;

  Future<void> addUser(Users user) async {
    try {
      await _firestore.collection('users').doc(user.id.toString()).set(user.toMap());
      await fetchUsersFromFirebase(); // Обновляем список пользователей после добавления
    } catch (e) {
      print("Ошибка при добавлении пользователя: $e");
    }
  }

  Future<void> fetchUsersFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      _users = snapshot.docs.map((doc) {
        return Users.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Ошибка при получении пользователей из Firebase: $e");
    }
  }
}
