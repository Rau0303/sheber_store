class User {
  final int id;
  final String name;
  final String phoneNumber;
  final String? photo;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'photo': photo,
    };
  }
}
