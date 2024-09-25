import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  final encrypt.Key _key = encrypt.Key.fromLength(32); // Генерация ключа AES
  late final encrypt.Encrypter _encrypter; 

  EncryptionHelper() {
    _encrypter = encrypt.Encrypter(encrypt.AES(_key)); 
  }

  String encryptData(String data) {
    // Генерация случайного IV
    final iv = encrypt.IV.fromLength(16);

    // Шифруем данные
    final encrypted = _encrypter.encrypt(data, iv: iv);

    // Сохраняем IV и зашифрованные данные вместе
    return '${base64.encode(iv.bytes)}:${encrypted.base64}';
  }

  String decryptData(String encryptedData) {
    // Разделяем IV и зашифрованные данные
    final parts = encryptedData.split(':');
    if (parts.length != 2) {
      throw Exception('Invalid encrypted data format');
    }
    
    final iv = encrypt.IV.fromBase64(parts[0]);
    final encryptedString = parts[1];

    // Расшифровываем данные
    return _encrypter.decrypt64(encryptedString, iv: iv);
  }
}
