import 'package:sheber_market/models/order.dart';
import 'package:sheber_market/models/product.dart';
import 'package:sheber_market/models/order_product.dart';

class OrderInformLogic {
  final int orderId;
  Order? order;
  List<Product> products = []; // Список продуктов
  List<OrderProduct> orderProducts = []; // Связь заказа и продуктов
  double price = 0.0;
  int deliverySumm = 0;
  double sum = 0.0;

  OrderInformLogic({required this.orderId});

  Future<void> fetchOrder() async {
    
  }

  Future<void> fetchOrderProducts() async {
    
  }

  Future<void> fetchProducts() async {
    
  }
}
