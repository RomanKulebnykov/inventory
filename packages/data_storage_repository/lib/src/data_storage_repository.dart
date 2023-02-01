import 'package:data_storage_local/data_storage_local.dart';
import 'package:data_storage_remote/data_storage_remote.dart';

enum FileType {
  productImage,
  brendImage;
}

class DataStorageRepository {
  final DataStorageRemote remote;
  final DataStorageLocal local;
  final String basePath;

  DataStorageRepository({
    required this.remote,
    required this.local,
    required this.basePath,
  });

  Future<String?> updateProductImage() async {}
}
