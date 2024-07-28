// lib/models/favorite_item.dart

class FavoriteItem {
  final int productId;

  FavoriteItem({
    required this.productId,
  });

  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      productId: map['product_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
    };
  }
}
