class FavoriteItem {
  final String userId;
  final int productId;

  FavoriteItem({
    required this.userId,
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'product_id': productId,
    };
  }

  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      userId: map['user_id'],
      productId: map['product_id'],
    );
  }
}
