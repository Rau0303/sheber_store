import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  final _encrypter = encrypt.Encrypter(encrypt.AES(
    encrypt.Key.fromLength(32),
    mode: encrypt.AESMode.cbc,
  ));
  final _iv = encrypt.IV.fromLength(16);

  String encryptData(String data) {
    return _encrypter.encrypt(data, iv: _iv).base64;
  }

  String decryptData(String encryptedData) {
    return _encrypter.decrypt64(encryptedData, iv: _iv);
  }
}
