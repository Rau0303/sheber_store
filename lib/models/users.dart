// lib/models/user.dart

class Users {
  final int id;
  final String name;
  final String phoneNumber;
  final String? photo;

  Users({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.photo,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phone_number'],
      photo: map['photo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'photo': photo,
    };
  }
}
