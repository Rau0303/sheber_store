import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/user_address.dart';

class UserAddressProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserAddress> _userAddresses = [];
  List<UserAddress> get userAddresses => _userAddresses;

  Future<void> loadUserAddresses() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Загружаем адреса из Firebase
    final snapshot = await _firestore
        .collection('user_addresses')
        .where('user_id', isEqualTo: userId)
        .get();

    _userAddresses = snapshot.docs.map((doc) => UserAddress.fromMap(doc.data())).toList();
    notifyListeners();
  }

  Future<void> addUserAddress(UserAddress address) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    final newAddress = UserAddress.withUserId(address, userId);

    // Сохраняем адрес в Firebase
    await _firestore.collection('user_addresses').add(newAddress.toMap());

    // Обновляем список адресов
    _userAddresses.add(newAddress);
    notifyListeners();
  }

  Future<void> updateUserAddress(UserAddress address) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    final updatedAddress = UserAddress.withUserId(address, userId);

    // Находим идентификатор документа в Firestore
    final snapshot = await _firestore
        .collection('user_addresses')
        .where('user_id', isEqualTo: userId)
        .get();
    final docId = snapshot.docs.first.id;

    // Обновляем адрес в Firebase
    await _firestore.collection('user_addresses').doc(docId).update(updatedAddress.toMap());

    // Обновляем список адресов
    final index = _userAddresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      _userAddresses[index] = updatedAddress;
      notifyListeners();
    }
  }

  Future<void> deleteUserAddress(int addressId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Находим идентификатор документа в Firestore
    final snapshot = await _firestore
        .collection('user_addresses')
        .where('user_id', isEqualTo: userId)
        .get();
    final docId = snapshot.docs.first.id;

    // Удаляем адрес из Firebase
    await _firestore.collection('user_addresses').doc(docId).delete();

    // Обновляем список адресов
    _userAddresses.removeWhere((a) => a.id == addressId);
    notifyListeners();
  }
}
