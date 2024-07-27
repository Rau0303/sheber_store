import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibration/vibration.dart';

class ProfileSettingsLogic {
  File? file;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  ProfileSettingsLogic() {
    // Инициализация логики, например, загрузка данных профиля
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    // Загрузка данных профиля, замените это заглушкой
    nameController.text = 'Тест Имя';
    phoneController.text = '+7(000)-000-00-00';
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = File(pickedFile.path);
    }
  }

  Future<void> saveProfile() async {
    Vibration.vibrate(duration: 50);
    // Логика сохранения профиля
    
  }
}
