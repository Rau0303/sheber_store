import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/user_address.dart';
import 'package:sheber_market/providers/database_helper.dart';

class UserAddressProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<UserAddress> _userAddresses = [];

  List<UserAddress> get userAddresses => _userAddresses;

  Future<void> addUserAddress(UserAddress address) async {
    try {
      // Добавить адрес в локальную базу данных
      await _dbHelper.insertUserAddress(address);

      // Добавить адрес в Firestore
      await _firestore.collection('user_addresses').doc(address.id.toString()).set(address.toMap());

      _userAddresses.add(address);
      notifyListeners();
    } catch (e) {
      print("Ошибка при добавлении адреса: $e");
    }
  }

  Future<void> updateUserAddress(UserAddress address) async {
    try {
      // Обновить адрес в локальной базе данных
      await _dbHelper.updateUserAddress(address);

      // Обновить адрес в Firestore
      await _firestore.collection('user_addresses').doc(address.id.toString()).update(address.toMap());

      // Обновить локальный список
      int index = _userAddresses.indexWhere((a) => a.id == address.id);
      if (index != -1) {
        _userAddresses[index] = address;
        notifyListeners();
      }
    } catch (e) {
      print("Ошибка при обновлении адреса: $e");
    }
  }

  Future<void> deleteUserAddress(int id) async {
    try {
      // Удалить адрес из локальной базы данных
      await _dbHelper.deleteUserAddress(id);

      // Удалить адрес из Firestore
      await _firestore.collection('user_addresses').doc(id.toString()).delete();

      // Удалить из локального списка
      _userAddresses.removeWhere((a) => a.id == id);
      notifyListeners();
    } catch (e) {
      print("Ошибка при удалении адреса: $e");
    }
  }

  Future<void> clearUserAddresses() async {
    try {
      // Очистить все адреса из локальной базы данных
      await _dbHelper.clearUserAddresses();

      // Очистить все адреса из Firestore
      var batch = _firestore.batch();
      var addressesCollection = _firestore.collection('user_addresses');
      var addressesSnapshot = await addressesCollection.get();
      for (var doc in addressesSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      _userAddresses.clear();
      notifyListeners();
    } catch (e) {
      print("Ошибка при очистке всех адресов: $e");
    }
  }

  Future<void> syncUserAddressesFromFirebase() async {
    try {
      // Получить все адреса из Firestore
      QuerySnapshot snapshot = await _firestore.collection('user_addresses').get();
      List<UserAddress> fetchedAddresses = snapshot.docs.map((doc) {
        return UserAddress.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      // Обновить локальную базу данных
      for (var address in fetchedAddresses) {
        await _dbHelper.insertUserAddress(address);
      }

      // Обновить локальный список
      _userAddresses = fetchedAddresses;
      notifyListeners();
    } catch (e) {
      print("Ошибка при синхронизации адресов: $e");
    }
  }

  Future<void> loadUserAddresses() async {
    try {
      // Загрузить адреса из локальной базы данных
      _userAddresses = await _dbHelper.queryAllUserAddresses();
      notifyListeners();
    } catch (e) {
      print("Ошибка при загрузке адресов: $e");
    }
  }
}
