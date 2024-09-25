import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheber_market/models/user_bank_card.dart';
import 'package:sheber_market/providers/user_bank_card_provider.dart';

class PaymentCardsLogic extends ChangeNotifier {
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

      // Если карты не пустые, выбираем первую или последнюю
      if (cards.isNotEmpty) {
        selectedCard = cards.length == 1 ? cards.first : cards.last;
      } else {
        selectedCard = null;
      }

      notifyListeners();
    }
  }

  Future<void> addCard(String cardNumber, String cardHolderName, String expiryDate, String cvv) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final card = UserBankCard(
      id: DateTime.now().millisecondsSinceEpoch, // Генерация уникального идентификатора
      userId: userId,
      cardNumber: cardNumber,
      cardExpiry: expiryDate,
      cardholderName: cardHolderName,
      cvv: cvv,
    );

    final provider = Provider.of<UserBankCardProvider>(context, listen: false);
    await provider.addUserBankCard(card);

    // Обновляем список карт
    await loadSelectedCard();

    selectedCard = cards.length == 1 ? card : cards.last;
    notifyListeners();
  }

  Future<List<UserBankCard>> loadCards() async {
    final snapshot = await FirebaseFirestore.instance.collection('cards').get();
    return snapshot.docs.map((doc) {
      return UserBankCard(
        id: doc['id'],
        userId: doc['user_id'],
        cardNumber: doc['card_number'],
        cardExpiry: doc['card_expiry'],
        cardholderName: doc['cardholder_name'],
        cvv: doc['cvv'],
      );
    }).toList();
  }

  void updateSelectedCard(UserBankCard card, bool isSelected) {
    if (isSelected) {
      selectedCard = card;
    } else {
      selectedCard = null;
    }
    notifyListeners();
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
