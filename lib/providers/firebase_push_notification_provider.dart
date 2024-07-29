import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebasePushNotificationProvider with ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _token;

  String? get token => _token;

  FirebasePushNotificationProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Запрос разрешений на получение уведомлений
    await _firebaseMessaging.requestPermission();

    // Получение токена устройства
    try {
      _token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $_token");
    } catch (e) {
      print("Error getting token: $e");
    }
    notifyListeners();
  }

  void subscribeToTopic(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
