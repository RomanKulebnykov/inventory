import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class DataStorageRemote {
  DataStorageRemote(this.storage);

  final FirebaseStorage storage;

  getFile() {}

  Future<String?> saveFile({
    required String path,
    required String filename,
    required Uint8List bytes,
  }) async {
    try {
      final ref = storage.ref('$path/$filename');
      await ref.putData(bytes);
      return ref.fullPath;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
