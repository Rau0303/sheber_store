import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sheber_market/screens/auth/login_screen/login_screen_logic.dart';
import 'package:sheber_market/screens/auth/widgets/login_form.dart';
import 'package:sheber_market/screens/auth/widgets/login_header.dart';
import 'package:sheber_market/theme/adaptive_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginScreenLogic _logic;

  @override
  void initState() {
    final phoneNumberController = MaskedTextController(mask: '+7(000)-000-00-00');
    final logger = Logger(printer: PrettyPrinter());
    _logic = LoginScreenLogic(phoneNumberController: phoneNumberController, logger: logger);
    super.initState();
  }

  @override
  void dispose() {
    _logic.phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = AdaptiveTheme.getTheme(context);
    final padding = EdgeInsets.all(screenSize.width * 0.05);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginHeader(
            imagePath: 'assets/Sheber.png',
            title: 'Авторизация',
            padding: padding,
          ),
          LoginForm(
            phoneNumberController: _logic.phoneNumberController,
            onLoginPressed: () => _logic.login(context),
          ),
        ],
      ),
    );
  }
}
