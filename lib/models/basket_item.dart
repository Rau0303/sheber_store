import 'package:sheber_market/models/product.dart';


class BasketItem {
  final Product product;
  int quantity;

  BasketItem({
    required this.product,
    required this.quantity,
  });

  factory BasketItem.fromJson(Map<String, dynamic> json) {
    return BasketItem(
      product: Product.fromMap(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }
}
