import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

enum ImageFormat {
  jpg,
  png;
}

class FileStorageFirebaseException implements Exception {}

class FileStorageFirebase {
  Future<String?> saveImage({
    required Reference reference,
    required Uint8List data,
  }) async {
    // final jpgImage = _convertToJpg(data);
    // if (jpgImage == null) return null;
    // await reference.putData(jpgImage);
    // return reference.fullPath;
  }
}
