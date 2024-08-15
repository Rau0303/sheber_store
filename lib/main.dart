import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/app/providers_setup.dart';
import 'package:sheber_market/app/sheber_market_app.dart';
import 'package:sheber_market/firebase_options.dart';

import 'package:sheber_market/providers/firebase_push_notification_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  final firebaseProvider = FirebasePushNotificationProvider();
  if (kDebugMode) {
    print(firebaseProvider.token);
  }
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  runApp(
    MultiProvider(
      providers: getProviders(), // Используйте функцию для получения списка провайдеров
      child: const SheberMarketApp(),
    ),
  );
}


