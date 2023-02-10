import 'package:products_catalog/src/i_brand_data_source.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../../products_catalog.dart';

class BrandsRepository extends IRepository<Brand, BrandFilter> {
  BrandsRepository({
    required IBrandDataSource local,
    required IBrandDataSource remote,
    required super.policies,
  })  : _local = local,
        _remote = remote;

  final IBrandDataSource _local;
  final IBrandDataSource _remote;

  @override
  IBrandDataSource get local => _local;

  @override
  IBrandDataSource get remote => _remote;

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
  Future<bool> save(Brand entity, {ImageStatus? imageStatus}) async {
    remote.save(entity);
    return false;
  }

  @override
  Stream<Brand> stream(BrandFilter filter) {
    // TODO: implement stream
    throw UnimplementedError();
  }
}
