import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen_logic.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/widgets/add_card_dialog.dart';
import 'package:sheber_market/widgets/add_app_bar.dart';


class PaymentCardsScreen extends StatefulWidget {
  static String route() => '/payment-cards'; // Укажите свой маршрут
  const PaymentCardsScreen({super.key});

  @override
  State<PaymentCardsScreen> createState() => _PaymentCardsScreenState();
}

class _PaymentCardsScreenState extends State<PaymentCardsScreen> {
  late PaymentCardsLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = PaymentCardsLogic(context);

    _logic.loadSelectedCard().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var cards = _logic.cards;
    return Scaffold(
      appBar: AddAppBar(
        onActionPressed:(){
          showAddCardDialog(context,_logic);
        }, 
        text: 'Мои карты'),
      body: ListView.separated(
        itemCount: cards.length,
        separatorBuilder: (context, index) => Divider(color: Theme.of(context).dividerColor),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: _logic.selectedCard == cards[index],
              onChanged: (newValue) {
                _logic.updateSelectedCard(cards[index], newValue ?? false);
                setState(() {}); // Обновить состояние экрана
              },
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            title: Text(cards[index].cardNumber),
            trailing: _logic.buildCardTypeIcon(cards[index].cardNumber),
          );
        },
      ),
    );
  }
}
