import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final String imagePath;
  final String title;
  final EdgeInsetsGeometry padding;

  const LoginHeader({
    super.key,
    required this.imagePath,
    required this.title,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Image.asset(imagePath),
    );
  }
}
