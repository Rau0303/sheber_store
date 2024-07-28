import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheber_market/models/users.dart';
import 'package:sheber_market/providers/database_helper.dart';


class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addUser(User user) async {
    try {
      // Добавить пользователя в локальную базу данных
     // await _dbHelper.deleteUser(user.id);


      // Добавить пользователя в Firestore
      await _firestore.collection('users').doc(user.id.toString()).set({
        'name': user.name,
        'phone_number': user.phoneNumber,
        'photo': user.photo,
      });
    } catch (e) {
      print("Ошибка при добавлении пользователя: $e");
    }
  }

  Future<List<User>> fetchUsers() async {
    return await _dbHelper.queryAllUsers();
  }
}
