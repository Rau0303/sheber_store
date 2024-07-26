// Модель адреса пользователя
class UserAddress {
  final int id;
  final int userId;
  final String city;
  final String? street;
  final String? house;
  final String? apartment;

  UserAddress({
    required this.id,
    required this.userId,
    required this.city,
    this.street,
    this.house,
    this.apartment,
  });

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      id: map['id'],
      userId: map['user_id'],
      city: map['city'],
      street: map['street'],
      house: map['house'],
      apartment: map['apartment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'city': city,
      'street': street,
      'house': house,
      'apartment': apartment,
    };
  }
}