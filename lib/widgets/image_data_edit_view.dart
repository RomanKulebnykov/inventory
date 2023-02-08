import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:inventory/utils/file_manager.dart';
import 'package:inventory/widgets/image_data_view.dart';
import 'package:shared_kernel/shared_kernel.dart';

class ImageDataEditView extends StatelessWidget {
  const ImageDataEditView({
    Key? key,
    this.width = 200,
    this.height = 200,
    this.image,
    required this.onImageChange,
    required this.onImageRemoved,
  }) : super(key: key);

  final double width;
  final double height;
  final ImageData? image;
  final Function(PlatformFile newImage) onImageChange;
  final Function() onImageRemoved;

  @override
  Widget build(BuildContext context) {
    final bool isSetImage = image?.data != null;
    final buttonColor = Theme.of(context).colorScheme.primary;
    return Stack(
      children: [
        ImageDataView(
          imageData: image,
          width: width,
          height: height,
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: isSetImage
              ? Row(
                  children: [
                    _updateImageButton(buttonColor),
                    _removeImageButton()
                  ],
                )
              : _addImageButton(),
        ),
      ],
    );
  }

  Widget _removeImageButton() {
    return IconButton(
      onPressed: onImageRemoved,
      icon: const Icon(Icons.delete_forever, color: Colors.red),
    );
  }

  Widget _updateImageButton(Color color) {
    return IconButton(
      color: color,
      onPressed: _changeImage,
      icon: const Icon(Icons.change_circle_outlined),
    );
  }

  Widget _addImageButton() {
    return ElevatedButton(
      onPressed: _changeImage,
      child: const Icon(Icons.add),
    );
  }

  _changeImage() async {
    final file = await FileManager.pickImage('Product Image');
    if (file != null) onImageChange(file);
  }
}
