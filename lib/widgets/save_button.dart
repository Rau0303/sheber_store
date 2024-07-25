import 'package:flutter/material.dart';

class Savebutton extends StatelessWidget {
  const Savebutton({
    super.key,
    required this.onPressed, required this.text,
  });

  
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.05,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: screenSize.width * 0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        ),
        child: Text(text),
      ),
    );
  }
}
