import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

class BrendDataSourceFirestore extends DataSource<Brand, BrandFilter> {
  @override
  Future<Brand> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Brand>> list(BrandFilter filter) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> save(Brand entity) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
