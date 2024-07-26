import 'package:flutter/material.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key, required this.photoUrls});

  final List<String> photoUrls;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.35,
      width: screenSize.width,
      child: photoUrls.isNotEmpty
          ? PageView.builder(
              itemCount: photoUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(photoUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No images available',
                style: Theme.of(context).textTheme.bodyMedium, // Используем bodyMedium для текста
              ),
            ),
    );
  }
}
