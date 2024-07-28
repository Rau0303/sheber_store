import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheber_market/models/users.dart';
import 'package:sheber_market/providers/user_provider.dart';
import 'package:sheber_market/utils/image_compressor.dart';

class ProfileSettingsLogic {
  File? file;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final UserProvider _userProvider = UserProvider();
  final ImageCompressor _imageCompressor = ImageCompressor();
  User? _currentUser;

  ProfileSettingsLogic() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    await _userProvider.fetchUsersFromLocal();
    if (_userProvider.users.isNotEmpty) {
      _currentUser = _userProvider.users.first;
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
        photo: photo?.path,
      );

      await _userProvider.addUser(_currentUser!);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      file = File(pickedFile.path);
    }
  }
}
