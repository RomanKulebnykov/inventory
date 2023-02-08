import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../infrastructure/product_filter.dart';

class ProductsRepository extends IRepository<Product, ProductFilter> {
  ProductsRepository({
    required super.policies,
    required super.local,
    required super.remote,
  });

  @override
  Future<Product> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> list(ProductFilter filter) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> save(Product entity) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Stream<Product> stream(ProductFilter filter) {
    // TODO: implement stream
    throw UnimplementedError();
  }
}
