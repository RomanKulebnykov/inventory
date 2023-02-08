import 'package:flutter/material.dart';
import 'package:shared_kernel/shared_kernel.dart';

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
    if (imageData?.data != null) {
      return Image.memory(
        imageData!.data!,
        height: height,
        width: width,
        fit: fit,
      );
      // } else if (imageData?.imageUrl != null) {
      //   return Image.network(
      //     imageData!.imageUrl!,
      //     height: height,
      //     width: width,
      //     fit: fit,
      //   );
    } else {
      return Placeholder(
        fallbackWidth: width ?? double.infinity,
        fallbackHeight: height ?? double.infinity,
      );
    }
  }
}
