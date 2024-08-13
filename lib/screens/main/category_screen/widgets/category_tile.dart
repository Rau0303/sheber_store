import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final void Function()? onTap;

  const CategoryTile({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: Container(
        height: screenSize.height * 0.12,
        width: screenSize.width * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(category.photoUrl!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        category.name,
        style: textTheme.titleLarge,
      ),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
