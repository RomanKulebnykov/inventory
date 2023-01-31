import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

enum FileType {
  productImage,
  brendImage;
}

class RemoteDataStorage {
  RemoteDataStorage(this.storage);

  final FirebaseStorage storage;

  getFile() {}

  Future<bool> saveFile({
    required String filename,
    required String extension,
    required Uint8List bytes,
    required FileType type,
  }) async {
    try {
      final ref = storage.ref('username/${type.name}/$filename');
      await ref.putData(bytes);
      print('OKKKK');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
