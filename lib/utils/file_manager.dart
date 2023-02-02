import 'package:file_picker/file_picker.dart';

class FileManager {
  static List<String> imagesExt = ['png', 'jpeg', 'jpg'];

  static Future<PlatformFile?> pickImage(String dialogTitle) async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: imagesExt,
      type: FileType.image,
      dialogTitle: dialogTitle,
      withData: true,
    );

    return result?.files.first;
  }
}
