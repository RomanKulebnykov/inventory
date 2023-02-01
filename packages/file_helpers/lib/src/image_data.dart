import 'dart:typed_data';

enum ImageStatus {
  normal,
  updated,
  deleted,
  empty;
}

class ImageData {
  final String name;
  final String extension;

  final Uint8List? bytes;
  final String? imageUrl;
  final String? imagePath;

  bool get hasImage => imageUrl != null || bytes != null;

  ImageData({
    required this.name,
    required this.bytes,
    required this.extension,
    this.imageUrl,
    this.imagePath,
  });

  ImageData copyWith({
    String? name,
    String? extension,
    Uint8List? bytes,
    String? imageUrl,
    String? imagePath,
  }) {
    return ImageData(
      name: name ?? this.name,
      extension: extension ?? this.extension,
      bytes: bytes ?? this.bytes,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
