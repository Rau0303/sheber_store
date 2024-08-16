import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheber_market/models/user_address.dart';
import 'package:sheber_market/models/basket_item.dart';

enum PaymentMethod { card, cash, undefined }
enum DeliveryMethod { courier, pickup, selfPickup, undefined }

class Order {
  final String id;
  final String userId;
  final DateTime orderDate;
  final double totalPrice;
  final UserAddress? deliveryAddress;
  final String status;
  final PaymentMethod paymentMethod;
  final DeliveryMethod deliveryMethod;
  final List<BasketItem> orderedProducts; // Добавлено поле для заказанных продуктов

  Order({
    required this.id,
    required this.userId,
    required this.orderDate,
    required this.totalPrice,
    this.deliveryAddress,
    required this.status,
    required this.paymentMethod,
    required this.deliveryMethod,
    required this.orderedProducts, // Инициализация нового поля
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['user_id'],
      orderDate: (map['order_date'] as Timestamp).toDate(),
      totalPrice: map['total_price'].toDouble(),
      deliveryAddress: map['delivery_address'] != null
          ? UserAddress.fromMap(map['delivery_address'])
          : null,
      status: map['status'],
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.toString() == 'PaymentMethod.${map['payment_method']}',
        orElse: () => PaymentMethod.undefined,
      ),
      deliveryMethod: DeliveryMethod.values.firstWhere(
        (e) => e.toString() == 'DeliveryMethod.${map['delivery_method']}',
        orElse: () => DeliveryMethod.undefined,
      ),
      orderedProducts: (map['ordered_products'] as List<dynamic>)
          .map((item) => BasketItem.fromJson(item))
          .toList(), // Преобразование списка JSON в список BasketItem
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'order_date': Timestamp.fromDate(orderDate),
      'total_price': totalPrice,
      'delivery_address': deliveryAddress?.toMap(),
      'status': status,
      'payment_method': paymentMethod.toString().split('.').last, 
      'delivery_method': deliveryMethod.toString().split('.').last, 
      'ordered_products': orderedProducts.map((item) => item.toJson()).toList(), // Преобразование списка BasketItem в JSON
    };
  }

  Order copyWith({
    String? id,
    String? userId,
    DateTime? orderDate,
    double? totalPrice,
    UserAddress? deliveryAddress,
    String? status,
    PaymentMethod? paymentMethod,
    DeliveryMethod? deliveryMethod,
    List<BasketItem>? orderedProducts,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orderDate: orderDate ?? this.orderDate,
      totalPrice: totalPrice ?? this.totalPrice,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      orderedProducts: orderedProducts ?? this.orderedProducts, // Копирование заказанных продуктов
    );
  }
}
