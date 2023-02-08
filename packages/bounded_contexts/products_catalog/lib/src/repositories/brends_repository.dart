import 'package:shared_kernel/shared_kernel.dart';

import '../../products_catalog.dart';

class BrandsRepository extends IRepository<Brand, BrandFilter> {
  BrandsRepository({
    required super.policies,
    required super.local,
    required super.remote,
  });

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
  Future<bool> save(Brand entity) async {
    remote.save(entity);
    return false;
  }

  @override
  Stream<Brand> stream(BrandFilter filter) {
    // TODO: implement stream
    throw UnimplementedError();
  }
}
