import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheber_market/models/user_bank_card.dart';

class UserBankCardProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<UserBankCard> _userBankCards = [];
  List<UserBankCard> get userBankCards => _userBankCards;

  Future<void> loadUserBankCards() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Загружаем банковские карты из Firebase
    final snapshot = await _firestore
        .collection('user_bank_cards')
        .where('user_id', isEqualTo: userId)
        .get();

    final firebaseBankCards = snapshot.docs.map((doc) => UserBankCard.fromMap(doc.data())).toList();

    // Обновляем список банковских карт
    _userBankCards.clear();
    _userBankCards.addAll(firebaseBankCards);
    notifyListeners();
  }

  Future<void> addUserBankCard(UserBankCard card) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Сохраняем карту в Firebase
    await _firestore.collection('user_bank_cards').add(card.toMap());

    // Обновляем список банковских карт
    _userBankCards.add(card);
    notifyListeners();
  }

  Future<void> updateUserBankCard(UserBankCard card) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Находим идентификатор документа в Firestore
    final snapshot = await _firestore
        .collection('user_bank_cards')
        .where('user_id', isEqualTo: userId)
        .get();
    
    // Находим документ с нужным `id` карты
    final doc = snapshot.docs.firstWhere((doc) => doc['id'] == card.id, orElse: () => throw Exception('Card not found'));
    final docId = doc.id;

    // Обновляем карту в Firebase
    await _firestore.collection('user_bank_cards').doc(docId).update(card.toMap());

    // Обновляем список банковских карт
    final index = _userBankCards.indexWhere((c) => c.id == card.id);
    if (index != -1) {
      _userBankCards[index] = card;
      notifyListeners();
    }
  }

  Future<void> deleteUserBankCard(int cardId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Находим идентификатор документа в Firestore
    final snapshot = await _firestore
        .collection('user_bank_cards')
        .where('user_id', isEqualTo: userId)
        .get();
    
    // Находим документ с нужным `id` карты
    final doc = snapshot.docs.firstWhere((doc) => doc['id'] == cardId, orElse: () => throw Exception('Card not found'));
    final docId = doc.id;

    // Удаляем карту из Firebase
    await _firestore.collection('user_bank_cards').doc(docId).delete();

    // Обновляем список банковских карт
    _userBankCards.removeWhere((c) => c.id == cardId);
    notifyListeners();
  }
}
