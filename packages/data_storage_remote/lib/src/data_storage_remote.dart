import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

enum FileType {
  productImage,
  brendImage;
}

class DataStorageRemote {
  DataStorageRemote(this.storage);

  final FirebaseStorage storage;
  final String basePath = 'username';

  getFile() {}

  Future<String?> saveFile({
    required String filename,
    required String extension,
    required Uint8List bytes,
    required FileType type,
  }) async {
    try {
      final ref = storage.ref('$basePath/${type.name}/$filename');
      await ref.putData(bytes);
      return ref.fullPath;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
