import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheber_market/models/user_bank_card.dart';

class PaymentCardsLogic {
  final BuildContext context;
  UserBankCard? selectedCard;
  List<UserBankCard> cards = [];

  PaymentCardsLogic(this.context);

  Future<void> loadSelectedCard() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      // Замените это на вашу реальную логику загрузки карт
      // final loadedCards = await someService.getPaymentCardsByOwnerId(userId);
      // cards = loadedCards;
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
      userId: int.parse(userId) , // ID пользователя
      cardNumber: cardNumber,
      cardExpiry: expiryDate,
      cardholderName: cardHolderName,
    );

    // Замените это на вашу реальную логику сохранения карты
    // await someService.savePaymentCard(card);
    cards.add(card); // Добавьте карту в локальный список
  }

  void updateSelectedCard(UserBankCard card, bool isSelected) {
    if (isSelected) {
      selectedCard = card;
      // Замените это на вашу реальную логику обновления выбранной карты
      // someService.setSelectedCard(card);
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
