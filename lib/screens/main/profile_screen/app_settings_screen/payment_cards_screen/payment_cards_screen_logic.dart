import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheber_market/models/user_bank_card.dart';
import 'package:sheber_market/providers/user_bank_card_provider.dart';

class PaymentCardsLogic {
  final BuildContext context;
  UserBankCard? selectedCard;
  List<UserBankCard> cards = [];

  PaymentCardsLogic(this.context);

  Future<void> loadSelectedCard() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final provider = Provider.of<UserBankCardProvider>(context, listen: false);
      await provider.loadUserBankCards();
      cards = provider.userBankCards;
      if (cards.isNotEmpty) {
        selectedCard = cards.last;
      }
    }
  }

  Future<void> addCard(String cardNumber, String cardHolderName, String expiryDate, String cvv) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final card = UserBankCard(
      id: DateTime.now().millisecondsSinceEpoch, // Уникальный идентификатор карты
      userId: int.parse(userId), // ID пользователя
      cardNumber: cardNumber,
      cardExpiry: expiryDate,
      cardholderName: cardHolderName,
    );

    final provider = Provider.of<UserBankCardProvider>(context, listen: false);
    await provider.addUserBankCard(card);
    cards.add(card); // Добавьте карту в локальный список
  }

  void updateSelectedCard(UserBankCard card, bool isSelected) {
    if (isSelected) {
      selectedCard = card;
    } else {
      selectedCard = null;
    }
  }

  Widget buildCardTypeIcon(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return Image.asset('assets/visa.png', width: 40, height: 40);
    } else if (cardNumber.startsWith('5')) {
      return Image.asset('assets/mastercard.png', width: 40, height: 40);
    } else if (cardNumber.startsWith('3')) {
      return Image.asset('assets/amex.png', width: 40, height: 40);
    } else {
      return Image.asset('assets/unknown.png', width: 40, height: 40);
    }
  }
}
