
// Модель заказа
class Order {
  final int id;
  final int? userId;
  final DateTime orderDate;
  final double totalPrice;
  final int? deliveryAddressId;
  final String status;

  Order({
    required this.id,
    this.userId,
    required this.orderDate,
    required this.totalPrice,
    this.deliveryAddressId,
    required this.status,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['user_id'],
      orderDate: DateTime.parse(map['order_date']),
      totalPrice: map['total_price'].toDouble(),
      deliveryAddressId: map['delivery_address_id'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'order_date': orderDate.toIso8601String(),
      'total_price': totalPrice,
      'delivery_address_id': deliveryAddressId,
      'status': status,
    };
  }
}