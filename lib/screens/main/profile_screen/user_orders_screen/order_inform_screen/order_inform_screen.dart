import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/user_orders_screen/order_inform_screen/order_inform_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/user_orders_screen/order_inform_screen/widgets/order_info_list.dart';
import 'package:sheber_market/screens/main/profile_screen/user_orders_screen/order_inform_screen/widgets/product_card.dart';
import 'package:sheber_market/widgets/default_app_bar.dart';

class OrderInformScreen extends StatefulWidget {
  final int orderId;

  const OrderInformScreen({super.key, required this.orderId});

  @override
  State<OrderInformScreen> createState() => _OrderInformScreenState();
}

class _OrderInformScreenState extends State<OrderInformScreen> {
  late OrderInformLogic _controller;

  @override
  void initState() {
    super.initState();
    _controller = OrderInformLogic(
      orderId: widget.orderId,
    );
    _controller.fetchOrder().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (_controller.order == null) {
      return Scaffold(
        appBar: DefaultAppBar(text: 'Номер заказа ${widget.orderId}'),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: DefaultAppBar(text: 'Номер заказа ${widget.orderId}'),
      body: ListView(
        padding: EdgeInsets.all(screenSize.height * 0.02),
        children: [
          for (var op in _controller.orderProducts)
            OrderProductCard(
              product: _controller.products.firstWhere((p) => p.id == op.productId),
              quantity: op.quantity,
              price: op.price,
            ),
          OrderInfoList(
            priceLabels:const [
              'Доставка',
              'Сумма',
              'Оплачено'
            ],
            deliverySumm: _controller.deliverySumm,
            sum: _controller.sum,
            order: _controller.order,
          ),
        ],
      ),
    );
  }
}
