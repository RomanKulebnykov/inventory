import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_kernel/shared_kernel.dart';

enum ImageType {
  logo('logo.jpg');

  final String fileName;
  const ImageType(this.fileName);
}

class FileStorageFirebaseException implements Exception {}

/// ======================================================== FileStorageFirebase
class FileStorageFirebase {
  final Reference Function() getBasePath;

  FileStorageFirebase(this.getBasePath);

  /// ----------------------------------------------------------------- getImage
  Future<ImageData?> getLogoImage(String id) async {
    try {
      final logoRef = getBasePath().child(id).child(ImageType.logo.fileName);
      final logoUrl = await _getFileURL(logoRef);
      return ImageData(imageURL: logoUrl);
    } catch (e) {
      return null;
    }
  }

  /// ----------------------------------------------------- updateImageInStorage
  Future<bool> updateLogoImage({
    required String entityId,
    ImageUpdateParam? updateParam,
  }) async {
    bool hasLogo;
    final path = getBasePath().child(entityId).child(ImageType.logo.fileName);
    if (updateParam is ImageUpdateParamReplace) {
      await _saveFile(path, updateParam.bytes);
      hasLogo = true;
    } else if (updateParam is ImageUpdateParamRemove) {
      await _deleteFile(path);
      hasLogo = false;
    } else {
      hasLogo = await _fileIsExists(path) != null;
    }
    return hasLogo;
  }

  /// //////////////////////////////////////////////////////////////////////////
  /// ----------------------------------------------------------- PRIVATE METHOD
  /// //////////////////////////////////////////////////////////////////////////

  /// --------------------------------------------------------------- getFileURL
  Future<String?> _getFileURL(Reference ref) async {
    try {
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  /// ------------------------------------------------------------- fileIsExists
  Future<FullMetadata?> _fileIsExists(Reference reference) async {
    try {
      final metadata = await reference.getMetadata();
      return metadata;
    } catch (e) {
      return null;
    }
  }

  /// --------------------------------------------------------------- deleteFile
  Future<bool> _deleteFile(Reference reference) async {
    try {
      await reference.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// ----------------------------------------------------------------- saveFile
  Future<bool> _saveFile(
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
