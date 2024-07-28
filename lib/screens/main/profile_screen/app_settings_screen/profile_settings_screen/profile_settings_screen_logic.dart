import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheber_market/models/users.dart';
import 'package:sheber_market/providers/user_service.dart';
import 'package:sheber_market/utils/image_compressor.dart';

class ProfileSettingsLogic {
  File? file;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final UserService _userService = UserService();
  final ImageCompressor _imageCompressor = ImageCompressor();
  User? _currentUser;

  ProfileSettingsLogic() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    List<User> users = await _userService.fetchUsersFromLocal();
    
    if (users.isNotEmpty) {
      _currentUser = users.first;
      nameController.text = _currentUser!.name;
      phoneController.text = _currentUser!.phoneNumber;
    } else {
      _currentUser = User(id: 0, name: '', phoneNumber: '');
    }
  }

  Future<void> saveProfile() async {
    final String name = nameController.text.trim();
    final String phoneNumber = phoneController.text.trim();
    final File? photo = file != null ? await _imageCompressor.compressImage(file!) : null;

    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: name,
        phoneNumber: phoneNumber,
        // Assuming the photo field in User model expects a String? type
        photo: photo?.path, // Converting File to String by using the file path
      );

      await _userService.addUser(_currentUser!);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Use pickImage instead of getImage

    if (pickedFile != null) {
      file = File(pickedFile.path);
    }
  }
}
