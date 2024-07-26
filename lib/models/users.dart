import 'package:flutter/material.dart';

// Модель пользователя
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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








