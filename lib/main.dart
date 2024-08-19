import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/app/providers_setup.dart';
import 'package:sheber_market/app/sheber_market_app.dart';
import 'package:sheber_market/firebase_options.dart';

import 'package:sheber_market/providers/firebase_push_notification_provider.dart';
import 'package:sheber_market/sync/sync_manager.dart';
import 'package:workmanager/workmanager.dart';


void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final SyncManager syncManager = SyncManager();

    // Выполняем синхронизацию в фоновом режиме
    await syncManager.syncCategories();
    await syncManager.syncProducts();

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // Планируем выполнение задачи раз в день
    Workmanager().registerPeriodicTask(
      "syncTask",
      "syncTask",
      frequency: const Duration(days: 2),
    );

  final firebaseProvider = FirebasePushNotificationProvider();
  if (kDebugMode) {
    print(firebaseProvider.token);
  }
  
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('6LfSrCMqAAAAAOn_BCzo5jt9sgRjGxTut8Bsmw99'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(
    MultiProvider(
      providers: getProviders(), // Используйте функцию для получения списка провайдеров
      child: const SheberMarketApp(),
    ),
  );
}
