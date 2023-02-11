import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../shared_kernel.dart';

/// ================================================================ ImageStatus
// enum ImageStatus {
//   normal,
//   removed,
//   updated;
// }

/// ============================================================== EditImageData
class EditImageData with EquatableMixin {
  EditImageData.fromImageData(ImageData? imageData)
      : _bytes = imageData?.bytes,
        _imageURL = imageData?.imageURL,
        _imageUpdateParam = ImageUpdateParamNone();

  final Uint8List? _bytes;
  final String? _imageURL;
  ImageUpdateParam _imageUpdateParam;

  void replace(Uint8List bytes) =>
      _imageUpdateParam = ImageUpdateParamReplace(bytes);

  void remove() {
    if (_bytes != null || _imageURL != null) {
      _imageUpdateParam = ImageUpdateParamDelete();
    } else {
      _imageUpdateParam = ImageUpdateParamNone();
    }
  }

  ImageUpdateParam get updateParam => _imageUpdateParam;
  ImageData? get imageData {
    if (_imageUpdateParam is ImageUpdateParamNone) {
      return ImageData(bytes: _bytes, imageURL: _imageURL);
    }
    if (_imageUpdateParam is ImageUpdateParamReplace) {
      ImageData(
        bytes: (_imageUpdateParam as ImageUpdateParamReplace).bytes,
        imageURL: _imageURL,
      );
    }
    return null;
  }

  // ImageStatus get status {
  //   if (_updateImageParam is ImageUpdateParamNone) return ImageStatus.normal;
  //   if (_updateImageParam is ImageUpdateParamDelete) return ImageStatus.removed;
  //   if (_updateImageParam is ImageUpdateParamReplace)
  //     return ImageStatus.updated;
  //   throw UnimplementedError();
  // }

  Uint8List? get bytes {
    if (_imageUpdateParam is ImageUpdateParamReplace) {
      return (_imageUpdateParam as ImageUpdateParamReplace).bytes;
    }
    if (_imageUpdateParam is ImageUpdateParamDelete) {
      return null;
    }
    return _bytes;
  }

  @override
  List<Object?> get props => [_imageUpdateParam];
}

/// ================================================================ UpdateParam
abstract class ImageUpdateParam extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImageUpdateParamNone extends ImageUpdateParam {}

class ImageUpdateParamDelete extends ImageUpdateParam {}

class ImageUpdateParamReplace extends ImageUpdateParam {
  ImageUpdateParamReplace(this.bytes);
  final Uint8List bytes;

  @override
  List<Object?> get props => [super.props, bytes];
}
