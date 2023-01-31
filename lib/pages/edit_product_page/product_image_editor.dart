import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:inventory/utils/file_manager.dart';

class ProductImageEditor extends StatelessWidget {
  const ProductImageEditor({
    Key? key,
    this.width = 200,
    this.height = 200,
    this.image,
    required this.onImageChange,
  }) : super(key: key);

  final double width;
  final double height;
  final Image? image;
  final Function(PlatformFile newImage) onImageChange;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (image == null)
            ? Placeholder(
                color: Colors.grey,
                fallbackHeight: height,
                fallbackWidth: width,
              )
            : image!,
        Positioned(
          bottom: 8,
          right: 8,
          child: ElevatedButton(
              child: image == null
                  ? const Icon(Icons.add)
                  : const Icon(Icons.change_circle_outlined),
              onPressed: () async {
                final file = await FileManager.pickImage('Product Image');
                if (file != null) {
                  onImageChange(file);
                }
              }),
        ),
      ],
    );
  }
}
