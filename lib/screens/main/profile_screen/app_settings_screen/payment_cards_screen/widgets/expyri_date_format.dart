import 'package:flutter/services.dart';

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('/', '');

    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 2) {
        formattedText += '/';
      }
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}