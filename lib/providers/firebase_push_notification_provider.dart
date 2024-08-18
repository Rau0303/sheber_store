import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebasePushNotificationProvider with ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? _token;

  String? get token => _token;

  FirebasePushNotificationProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Запрос разрешений на получение уведомлений
    await _firebaseMessaging.requestPermission();

    // Настройка локальных уведомлений
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      
    );

    // Получение токена устройства
    try {
      _token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $_token");
    } catch (e) {
      print("Error getting token: $e");
    }
    notifyListeners();

    // Настройка обработчиков сообщений
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Обработка уведомлений при открытии приложения
      _onSelectNotification(message.data['payload']);
    });
  }

  void _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: message.data['payload'],
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    // Обработка нажатий на уведомления
    if (payload != null) {
      print('Notification payload: $payload');
      // Здесь можно добавить логику для навигации или выполнения действий
      // Например, перейти на определённый экран или обновить состояние
    }
  }

  void subscribeToTopic(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
