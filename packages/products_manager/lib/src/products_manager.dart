import 'dart:typed_data';

import 'domain/brand.dart';
import 'domain/product.dart';

/// ------------------------------------------------------------ ProductsManager
abstract class ProductsManager {
  Future<Brand> getBrendById(String id);
  Future<void> saveBrend(Brand brend);
  Future<Product> getProduct(String id);
  Future<List<Product>> getProducts();
  Future<void> saveProduct(Product product);
  Future<void> deleteProduct(String id);
}

/// ------------------------------------------------------------- ProductStorage
abstract class ProductStorage {
  Future<Uint8List?> getLocalFile(String filename);
  Future<void> saveFileLocal(Uint8List file);
  Future<Uint8List?> getRemoteFile(String filename);
  Future<void> saveFileRemote(Uint8List file);
}

/// --------------------------------------------------------------- BrandStorage
abstract class BrandStorage {
  Future<Uint8List?> getLocalFile(String filename);
  Future<void> saveFileLocal(Uint8List file);
  Future<Uint8List?> getRemoteFile(String filename);
  Future<void> saveFileRemote(Uint8List file);

  Future<Brand> getLocalObject(String id);
  Future<void> saveObjectLocal(Brand brand);
}
