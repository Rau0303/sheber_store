import 'package:flutter/material.dart';
import 'package:sheber_market/models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    required this.category,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: category.photoUrl != null
                    ? Image.network(
                        category.photoUrl!,
                        fit: BoxFit.fill,
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            'No Image',
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                category.name,
                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
