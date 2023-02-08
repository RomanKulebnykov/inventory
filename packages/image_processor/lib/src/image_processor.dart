import 'dart:typed_data';
import 'package:image/image.dart' as img_converter;

class ImageProcessor {
  static Uint8List? convertToJpg(Uint8List imageBytes) {
    final image = img_converter.decodeImage(imageBytes);
    if (image == null) return null;
    return img_converter.encodeJpg(image);
  }
}
