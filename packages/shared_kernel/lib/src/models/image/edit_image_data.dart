import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../shared_kernel.dart';

/// ================================================================ ImageStatus
enum ImageStatus {
  normal,
  removed,
  updated;
}

/// ============================================================== EditImageData
class EditImageData with EquatableMixin {
  EditImageData.fromImageData(ImageData? imageData)
      : _bytes = imageData?.bytes,
        _imageURL = imageData?.imageURL,
        _updateImageParam = _UpdateParamNone();

  final Uint8List? _bytes;
  final String? _imageURL;
  _UpdateParam _updateImageParam;

  void replace(Uint8List bytes) =>
      _updateImageParam = _UpdateParamReplace(bytes);

  void remove() {
    if (_bytes != null || _imageURL != null) {
      _updateImageParam = _UpdateParamDelete();
    } else {
      _updateImageParam = _UpdateParamNone();
    }
  }

  ImageData? get imageData {
    switch (status) {
      case ImageStatus.normal:
        return ImageData(bytes: _bytes, imageURL: _imageURL);
      case ImageStatus.removed:
        return null;
      case ImageStatus.updated:
        return ImageData(
          bytes: (_updateImageParam as _UpdateParamReplace).bytes,
          imageURL: _imageURL,
        );
    }
  }

  ImageStatus get status {
    if (_updateImageParam is _UpdateParamNone) return ImageStatus.normal;
    if (_updateImageParam is _UpdateParamDelete) return ImageStatus.removed;
    if (_updateImageParam is _UpdateParamReplace) return ImageStatus.updated;
    throw UnimplementedError();
  }

  Uint8List? get bytes {
    if (_updateImageParam is _UpdateParamReplace) {
      return (_updateImageParam as _UpdateParamReplace).bytes;
    }
    if (_updateImageParam is _UpdateParamDelete) {
      return null;
    }
    return _bytes;
  }

  @override
  List<Object?> get props => [_updateImageParam];
}

/// ================================================================ UpdateParam
abstract class _UpdateParam extends Equatable {
  @override
  List<Object?> get props => [];
}

class _UpdateParamNone extends _UpdateParam {}

class _UpdateParamDelete extends _UpdateParam {}

class _UpdateParamReplace extends _UpdateParam {
  _UpdateParamReplace(this.bytes);
  final Uint8List bytes;

  @override
  List<Object?> get props => [super.props, bytes];
}
