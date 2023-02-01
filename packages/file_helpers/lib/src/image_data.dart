import 'dart:typed_data';

class UpdateImage {
  final String name;
  final Uint8List? bytes;

  UpdateImage({
    required this.name,
    this.bytes,
  });
}

class ImageData {
  final String? name;
  final Uint8List? bytes;
  final String? imagePath;
  final bool isNeedDelete;
  final UpdateImage? replace;

  Uint8List? get bytesData {
    if (isNeedDelete == false) {
      return replace?.bytes ?? bytes;
    }
    return null;
  }

  ImageData addReplaceImage({
    required String name,
    required Uint8List bytes,
  }) {
    return ImageData(
      replace: UpdateImage(name: name, bytes: bytes),
      isNeedDelete: false,
      name: name,
      bytes: bytes,
      imagePath: imagePath,
    );
  }

  ImageData markNeedRemove() {
    return ImageData(
      replace: null,
      isNeedDelete: name != null ? true : false,
      name: name,
      bytes: bytes,
      imagePath: imagePath,
    );
  }

  ImageData({
    this.name,
    this.bytes,
    this.isNeedDelete = false,
    this.replace,
    this.imagePath,
  });

  ImageData copyWith({
    String? name,
    Uint8List? bytes,
    String? imageUrl,
    String? imagePath,
    bool? isNeedDelete,
    UpdateImage? replace,
  }) {
    return ImageData(
      name: name ?? this.name,
      bytes: bytes ?? this.bytes,
      imagePath: imagePath ?? this.imagePath,
      isNeedDelete: isNeedDelete ?? this.isNeedDelete,
      replace: replace ?? this.replace,
    );
  }
}
