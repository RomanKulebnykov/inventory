import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// ================================================================== ImageData
class ImageData extends Equatable {
  final Uint8List? bytes;
  final String? imageURL;

  const ImageData({
    this.bytes,
    this.imageURL,
  }) : assert(bytes != null || imageURL != null);

  ImageData copyWith({
    Uint8List? bytes,
    String? imageURL,
  }) {
    return ImageData(
      bytes: bytes ?? this.bytes,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  @override
  List<Object?> get props => [bytes, imageURL];
}
