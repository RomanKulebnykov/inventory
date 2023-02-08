import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img_converter;

enum ImageFormat {
  jpg,
  png;
}

class FileStorageFirebaseException implements Exception {}

class FileStorageFirebase {
  Uint8List? _convertToJpg(Uint8List imageBytes) {
    final image = img_converter.decodeImage(imageBytes);
    if (image == null) return null;
    return img_converter.encodeJpg(image);
  }

  Future<String?> saveImage({
    required Reference reference,
    required Uint8List data,
  }) async {
    final jpgImage = _convertToJpg(data);
    if (jpgImage == null) return null;
    await reference.putData(jpgImage);
    return reference.fullPath;
  }
}
