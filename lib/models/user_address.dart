class UserAddress {
  final int id;
  final String userId;
  final String city;
  final String street;
  final String house;
  final String apartment;

  UserAddress({
    required this.id,
    required this.userId,
    required this.city,
    required this.street,
    required this.house,
    required this.apartment,
  });

  UserAddress.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        userId = map['user_id'],
        city = map['city'],
        street = map['street'] ?? '',
        house = map['house'] ?? '',
        apartment = map['apartment'] ?? '';

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

  UserAddress.withUserId(UserAddress address, String newUserId)
      : id = address.id,
        userId = newUserId,
        city = address.city,
        street = address.street,
        house = address.house,
        apartment = address.apartment;
}
