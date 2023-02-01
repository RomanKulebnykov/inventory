import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class DataStorageRemote {
  DataStorageRemote(this.storage);

  final FirebaseStorage storage;

  Future<String?> getFileByName(String name) async {
    final basePath = 'username/productImage/aaa';
    final ref = storage.ref(basePath);
    ref;
    // final list = await ref.list();
    // for (final item in list.items) {
    //   print(item.name);
    // }
  }

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
