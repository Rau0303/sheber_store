import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().toIso8601String()}.jpg';
    final file = File('${directory.path}/$fileName');
    await image.copy(file.path);
    return file.path;
  }

  Future<File?> getImage(String path) async {
    return File(path);
  }
}
