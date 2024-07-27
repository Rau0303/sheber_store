
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';



class TermsOfUseLogic {
  final WebViewController controller;
  final Logger logger;
  bool isLoading;

  TermsOfUseLogic({
    required this.controller,
    required this.logger,
    this.isLoading = true,
  });

  Future<void> initializeWebView(String apiUrl) async {
    try {
      await clearCache();
      controller
        ..loadRequest(Uri.parse(apiUrl))
        ..setJavaScriptMode(JavaScriptMode.disabled)
        ..addJavaScriptChannel(
          'SnackBar',
          onMessageReceived: (message) {
            //SnackBarService.showSnackBar(message.message as BuildContext, false as bool);
          },
        );

      isLoading = false;
    } catch (e) {
      logger.e('Ошибка инициализации WebView: $e');
      isLoading = false;
    }
  }

  Future<void> clearCache() async {
    try {
      await DefaultCacheManager().emptyCache();
      logger.i('Кэш очищен');
    } catch (e) {
      logger.e('Ошибка очистки кэша: $e');
    }
  }
}