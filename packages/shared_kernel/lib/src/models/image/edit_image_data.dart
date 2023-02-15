import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../shared_kernel.dart';

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
      _imageUpdateParam = ImageUpdateParamRemove();
    } else {
      _imageUpdateParam = ImageUpdateParamNone();
    }
  }

  ImageUpdateParam get updateParam => _imageUpdateParam;

  ImageData? get initialImageData {
    if (_bytes != null || _imageURL != null) {
      return ImageData(bytes: _bytes, imageURL: _imageURL);
    } else {
      return null;
    }
  }

  ImageData? get imageData {
    if (_imageUpdateParam is ImageUpdateParamNone) {
      return initialImageData;
    }
    if (_imageUpdateParam is ImageUpdateParamReplace) {
      return ImageData(
        bytes: (_imageUpdateParam as ImageUpdateParamReplace).bytes,
        imageURL: null,
      );
    }
    return null;
  }

  Uint8List? get bytes {
    if (_imageUpdateParam is ImageUpdateParamReplace) {
      return (_imageUpdateParam as ImageUpdateParamReplace).bytes;
    }
    if (_imageUpdateParam is ImageUpdateParamRemove) {
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

class ImageUpdateParamRemove extends ImageUpdateParam {}

class ImageUpdateParamReplace extends ImageUpdateParam {
  ImageUpdateParamReplace(this.bytes);
  final Uint8List bytes;

  @override
  List<Object?> get props => [super.props, bytes];
}
