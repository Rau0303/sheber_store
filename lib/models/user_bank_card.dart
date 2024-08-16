class UserBankCard {
  final int id;
  final String userId;
  final String cardNumber;
  final String cardExpiry;
  final String cardholderName;
  final String cvv;

  UserBankCard({
    required this.id,
    required this.userId,
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardholderName,
    required this.cvv,
  });

  factory UserBankCard.fromMap(Map<String, dynamic> map) {
    return UserBankCard(
      id: map['id'],
      userId: map['user_id'],
      cardNumber: map['card_number'],
      cardExpiry: map['card_expiry'],
      cardholderName: map['cardholder_name'],
      cvv: map['cvv'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'card_number': cardNumber,
      'card_expiry': cardExpiry,
      'cardholder_name': cardholderName,
      'cvv': cvv,
    };
  }
}
