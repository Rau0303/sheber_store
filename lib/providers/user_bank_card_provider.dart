// Провайдер для банковских карт
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sheber_market/models/user_bank_card.dart';
import 'package:sheber_market/utils/encryption_helper.dart';

class UserBankCardProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final EncryptionHelper _encryptionHelper = EncryptionHelper();
  List<UserBankCard> _userBankCards = [];

  List<UserBankCard> get userBankCards => _userBankCards;

  Future<void> addUserBankCard(UserBankCard card) async {
    try {
      // Шифруем данные карты
      final encryptedCardNumber = _encryptionHelper.encryptData(card.cardNumber);
      final encryptedCardExpiry = _encryptionHelper.encryptData(card.cardExpiry);
      final encryptedCardholderName = _encryptionHelper.encryptData(card.cardholderName);

      final encryptedCard = UserBankCard(
        id: card.id,
        userId: card.userId,
        cardNumber: encryptedCardNumber,
        cardExpiry: encryptedCardExpiry,
        cardholderName: encryptedCardholderName,
      );

      // Добавляем карту в Firestore
      await _firestore.collection('user_bank_cards').doc(card.id.toString()).set(encryptedCard.toMap());

      _userBankCards.add(card);
      notifyListeners();
    } catch (e) {
      print("Ошибка при добавлении карты: $e");
    }
  }

  Future<void> updateUserBankCard(UserBankCard card) async {
    try {
      // Шифруем данные карты
      final encryptedCardNumber = _encryptionHelper.encryptData(card.cardNumber);
      final encryptedCardExpiry = _encryptionHelper.encryptData(card.cardExpiry);
      final encryptedCardholderName = _encryptionHelper.encryptData(card.cardholderName);

      final encryptedCard = UserBankCard(
        id: card.id,
        userId: card.userId,
        cardNumber: encryptedCardNumber,
        cardExpiry: encryptedCardExpiry,
        cardholderName: encryptedCardholderName,
      );

      // Обновляем карту в Firestore
      await _firestore.collection('user_bank_cards').doc(card.id.toString()).update(encryptedCard.toMap());

      // Обновляем локальный список
      int index = _userBankCards.indexWhere((c) => c.id == card.id);
      if (index != -1) {
        _userBankCards[index] = card;
        notifyListeners();
      }
    } catch (e) {
      print("Ошибка при обновлении карты: $e");
    }
  }

  Future<void> deleteUserBankCard(int id) async {
    try {
      // Удаляем карту из Firestore
      await _firestore.collection('user_bank_cards').doc(id.toString()).delete();

      // Удаляем из локального списка
      _userBankCards.removeWhere((c) => c.id == id);
      notifyListeners();
    } catch (e) {
      print("Ошибка при удалении карты: $e");
    }
  }

  Future<void> loadUserBankCards() async {
    try {
      final snapshot = await _firestore.collection('user_bank_cards').get();
      _userBankCards = snapshot.docs.map((doc) {
        final data = doc.data();
        final decryptedCardNumber = _encryptionHelper.decryptData(data['card_number']);
        final decryptedCardExpiry = _encryptionHelper.decryptData(data['card_expiry']);
        final decryptedCardholderName = _encryptionHelper.decryptData(data['cardholder_name']);

        return UserBankCard(
          id: data['id'],
          userId: data['user_id'],
          cardNumber: decryptedCardNumber,
          cardExpiry: decryptedCardExpiry,
          cardholderName: decryptedCardholderName,
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      print("Ошибка при загрузке карт: $e");
    }
  }
}