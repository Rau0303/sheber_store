import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheber_market/models/user_bank_card.dart';
import 'package:sheber_market/providers/database_helper.dart';


class UserBankCardProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<UserBankCard> _userBankCards = [];
  List<UserBankCard> get userBankCards => _userBankCards;

  Future<void> loadUserBankCards() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Загружаем банковские карты из локальной базы данных
    
    notifyListeners();

    // Загружаем банковские карты из Firebase
    final snapshot = await _firestore
        .collection('user_bank_cards')
        .where('user_id', isEqualTo: userId)
        .get();

    final firebaseBankCards = snapshot.docs.map((doc) => UserBankCard.fromMap(doc.data())).toList();

    // Сохраняем банковские карты в локальной базе данных
   

    // Обновляем список банковских карт
    _userBankCards.addAll(firebaseBankCards);
    notifyListeners();
  }

  Future<void> addUserBankCard(UserBankCard card) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Сохраняем карту в локальной базе данных
    

    // Сохраняем карту в Firebase
    await _firestore.collection('user_bank_cards').add(card.toMap());

    // Обновляем список банковских карт
    _userBankCards.add(card);
    notifyListeners();
  }

  Future<void> updateUserBankCard(UserBankCard card) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    // Обновляем карту в локальной базе данных
    
    // Находим идентификатор документа в Firestore
    final snapshot = await _firestore
        .collection('user_bank_cards')
        .where('user_id', isEqualTo: userId)
        .get();
    final docId = snapshot.docs.first.id;

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

    // Удаляем карту из локальной базы данных
    
    // Находим идентификатор документа в Firestore
    final snapshot = await _firestore
        .collection('user_bank_cards')
        .where('user_id', isEqualTo: userId)
        .get();
    final docId = snapshot.docs.first.id;

    // Удаляем карту из Firebase
    await _firestore.collection('user_bank_cards').doc(docId).delete();

    // Обновляем список банковских карт
    _userBankCards.removeWhere((c) => c.id == cardId);
    notifyListeners();
  }
}
