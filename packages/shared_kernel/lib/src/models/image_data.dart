import 'dart:typed_data';

// class UpdateImageParam {
//   UpdateImageParam(this.name);
//   final String name;
// }
//
// class UpdateImageParamDelete extends UpdateImageParam {
//   UpdateImageParamDelete(super.name);
// }
//
// class UpdateImageParamReplace extends UpdateImageParam {
//   UpdateImageParamReplace(super.name, this.bytes);
//   final Uint8List bytes;
// }

class ImageData {
  final Uint8List? bytes;
  final String? imageURL;

  const ImageData({
    this.bytes,
    this.imageURL,
  });

  ImageData copyWith({
    Uint8List? bytes,
    String? imageURL,
  }) {
    return ImageData(
      bytes: bytes ?? this.bytes,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  // UpdateImageParam? updateImageParam;
  //
  // Uint8List? get data {
  //   if (updateImageParam != null) {
  //     if (updateImageParam is UpdateImageParamReplace) {
  //       return (updateImageParam as UpdateImageParamReplace).bytes;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return _bytes;
  //   }
  // }
  //
  // void replace(String name, Uint8List bytes) {
  //   updateImageParam = UpdateImageParamReplace(name, bytes);
  // }
  //
  // void remove() {
  //   if (name != null) {
  //     updateImageParam = UpdateImageParamDelete(name!);
  //   } else {
  //     updateImageParam = null;
  //   }
  // }
  //
  // ImageData({
  //   this.name,
  //   Uint8List? bytes,
  //   this.imagePath,
  //   this.updateImageParam,
  // }) : _bytes = bytes;
  //
  // ImageData copyWith({
  //   String? name,
  //   Uint8List? bytes,
  //   String? imagePath,
  //   UpdateImageParam? updateImageParam,
  // }) {
  //   return ImageData(
  //     name: name ?? this.name,
  //     bytes: bytes ?? _bytes,
  //     imagePath: imagePath ?? this.imagePath,
  //     updateImageParam: updateImageParam ?? this.updateImageParam,
  //   );
  // }

  // @override
  // String toString() {
  //   return 'ImageData{name: $name, _bytes: ${_bytes?.length}, imagePath: $imagePath, updateImageParam: $updateImageParam}';
  // }
}
