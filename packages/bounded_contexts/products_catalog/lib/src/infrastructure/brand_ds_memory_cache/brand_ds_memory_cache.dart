import 'package:products_catalog/src/i_brand_data_source.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../../../products_catalog.dart';

class BrandDataSourceMemoryCache extends IBrandDataSource {
  @override
  Future<Brand?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Brand>> list(BrandFilter filter) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String id, {ImageData? removedImage}) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> save(Brand entity, {ImageUpdateParam? updateParam}) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
