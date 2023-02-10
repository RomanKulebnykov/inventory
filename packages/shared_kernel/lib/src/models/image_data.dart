import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// =========================================================== UpdateImageParam
abstract class UpdateImageParam {}

class UpdateImageParamNone extends UpdateImageParam {}

class UpdateImageParamDelete extends UpdateImageParam {}

class UpdateImageParamReplace extends UpdateImageParam {
  UpdateImageParamReplace(this.bytes);
  final Uint8List bytes;
}

/// ================================================================ ImageStatus
enum ImageStatus {
  normal,
  removed,
  updated;
}

/// ============================================================== EditImageData
class EditImageData extends ImageData with EquatableMixin {
  EditImageData() : updateImageParam = UpdateImageParamNone();
  UpdateImageParam updateImageParam;

  void replace(Uint8List bytes) =>
      updateImageParam = UpdateImageParamReplace(bytes);

  void remove() {
    if (super.bytes != null || super.imageURL != null) {
      updateImageParam = UpdateImageParamDelete();
    } else {
      updateImageParam = UpdateImageParamNone();
    }
  }

  ImageStatus get status {
    if (updateImageParam is UpdateImageParamNone) return ImageStatus.normal;
    if (updateImageParam is UpdateImageParamDelete) return ImageStatus.removed;
    if (updateImageParam is UpdateImageParamReplace) return ImageStatus.updated;
    throw UnimplementedError();
  }

  @override
  Uint8List? get bytes {
    if (updateImageParam is UpdateImageParamReplace) {
      return (updateImageParam as UpdateImageParamReplace).bytes;
    }
    if (updateImageParam is UpdateImageParamDelete) {
      return null;
    }
    return super.bytes;
  }

  @override
  List<Object?> get props => [updateImageParam];
}

/// ================================================================== ImageData
class ImageData {
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
}
