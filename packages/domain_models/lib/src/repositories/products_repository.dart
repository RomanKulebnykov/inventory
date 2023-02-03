import 'package:domain_models/domain_models.dart';

/// ------------------------------------------------------------ ProductsRepository
abstract class ProductsRepository {
  Future<Brand> getBrendById(String id);
  Future<void> saveBrend(Brand brend);
  Future<void> deleteBrand(String id);
  Future<List<Brand>> getBrands();

  Future<Product> getProduct(String id);
  Future<List<Product>> getProducts();
  Future<void> saveProduct(Product product);
  Future<void> deleteProduct(String id);
}

abstract class ProductFirestoreDataSource {}

abstract class BrandFirestoreDataSource {}

abstract class BrandLocalDataSource {}

abstract class RemoteFileDataSource {}

abstract class LocalFileDataSource {}
