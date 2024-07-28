// lib/models/cart_item.dart

class CartItem {
  final int productId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['product_id'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }
}
