import 'dart:typed_data';

class ImageData {
  final String name;
  final String extension;
  final Uint8List? bytes;
  final String? imageUrl;
  final String? imagePath;

  ImageData({
    required this.name,
    required this.bytes,
    required this.extension,
    this.imageUrl,
    this.imagePath,
  });
}
