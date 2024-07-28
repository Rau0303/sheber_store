import 'dart:io';
import 'package:image/image.dart' as img;

class ImageCompressor {
  // Метод для сжатия изображения
  Future<File> compressImage(File file, {int targetWidth = 400, int quality = 50}) async {
    final bytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    if (image != null) {
      // Уменьшение разрешения изображения
      img.Image resized = img.copyResize(image, width: targetWidth);

      // Снижение качества JPEG сжатия
      final compressedBytes = img.encodeJpg(resized, quality: quality);

      // Запись сжатого изображения в файл
      return File(file.path)..writeAsBytesSync(compressedBytes);
    }
    return file;
  }
}
