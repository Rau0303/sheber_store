import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('phoneField'),
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Введите номер телефона',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        if (value.length == 17) {
          FocusScope.of(context).unfocus();
        }
      },
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
    );
  }
}
