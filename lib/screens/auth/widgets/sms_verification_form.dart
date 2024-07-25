import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sheber_market/widgets/save_button.dart';


class SmsVerificationForm extends StatelessWidget {
  final TextEditingController smsController;
  final VoidCallback onVerifyPressed;

  const SmsVerificationForm({
    super.key,
    required this.smsController,
    required this.onVerifyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = EdgeInsets.all(screenSize.width * 0.05);

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
    );

    return Container(
      height: screenSize.height * 0.4,
      width: screenSize.width,
      decoration:  BoxDecoration(
        color: Colors.grey[600],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(60)),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.02),
            const Text('Верификация', style: TextStyle(color: Colors.white)),
            SizedBox(height: screenSize.height * 0.01),
            const Text('Введите код верификации', style: TextStyle(color: Colors.white)),
            SizedBox(height: screenSize.height * 0.02),
            Pinput(
              controller: smsController,
              length: 6,
              defaultPinTheme: defaultPinTheme,
            ),
            SizedBox(height: screenSize.height * 0.03),
            Savebutton(
              onPressed: onVerifyPressed, 
              text: 'Войти')
          ],
        ),
      ),
    );
  }
}
