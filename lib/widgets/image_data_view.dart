import 'package:file_helpers/file_helpers.dart';
import 'package:flutter/material.dart';

class ImageDataView extends StatelessWidget {
  const ImageDataView({
    Key? key,
    required this.imageData,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final ImageData? imageData;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    if (imageData?.bytes != null) {
      return Image.memory(
        imageData!.bytes!,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (imageData?.imageUrl != null) {
      return Image.network(
        imageData!.imageUrl!,
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return Placeholder(
        fallbackWidth: width ?? double.infinity,
        fallbackHeight: height ?? double.infinity,
      );
    }
  }
}
