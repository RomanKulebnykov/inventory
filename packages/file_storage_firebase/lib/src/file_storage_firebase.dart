import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_kernel/shared_kernel.dart';

enum ImageFormat {
  jpg,
  png;
}

class FileStorageFirebaseException implements Exception {}

class FileStorageFirebase {
  /// --------------------------------------------------------------- getFileURL
  static Future<String?> getFileURL(Reference ref) async {
    try {
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  /// ------------------------------------------------------------- fileIsExists
  static Future<FullMetadata?> fileIsExists(Reference reference) async {
    try {
      final metadata = await reference.getMetadata();
      return metadata;
    } catch (e) {
      return null;
    }
  }

  /// --------------------------------------------------------------- deleteFile
  static Future<bool> deleteFile(Reference reference) async {
    try {
      await reference.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// ----------------------------------------------------------------- saveFile
  static Future<bool> saveFile(
    Reference reference,
    Uint8List bytes,
  ) async {
    try {
      await reference.putData(bytes);
      return true;
    } catch (e) {
      return false;
    }
  }
}
