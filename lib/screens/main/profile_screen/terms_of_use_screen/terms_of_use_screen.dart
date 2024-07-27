import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/terms_of_use_screen/terms_of_use_screen_logic.dart';
import 'package:sheber_market/widgets/default_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:logger/logger.dart';


class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  late final WebViewController _controller;
  late final TermsOfUseLogic _controllerLogic;

  static const String apiUrl = 'https://www.termsfeed.com/live/2a2c278c-9876-4b2f-bbf4-efa223965464';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controllerLogic = TermsOfUseLogic(
      controller: _controller,
      logger: Logger(printer: PrettyPrinter()),
    );
    _controllerLogic.initializeWebView(apiUrl);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    

    return Scaffold(
      appBar:const DefaultAppBar(text: 'Условия использования'),
      body: _controllerLogic.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            )
          : WebViewWidget(controller: _controller),
    );
  }
}
