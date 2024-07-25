import 'package:flutter/material.dart';
import 'package:sheber_market/screens/auth/widgets/sms_verification_form.dart';
import 'package:sheber_market/theme/adaptive_theme.dart';
import 'sms_verification_logic.dart';


class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  late SmsVerificationLogic _logic;

  @override
  void initState() {
    super.initState();
    final smsController = TextEditingController();
    _logic = SmsVerificationLogic(smsController: smsController);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = AdaptiveTheme.getTheme(context);

    return Scaffold(
      backgroundColor:theme.scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenSize.width * 0.05),
            child: Image.asset('assets/Sheber.png'),
          ),
          SmsVerificationForm(
            smsController: _logic.smsController,
            onVerifyPressed: () => _logic.verify(context, widget.verificationId),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _logic.smsController.dispose();
    super.dispose();
  }
}
