import 'package:products_catalog/src/brand/i_brand_data_source.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../../products_catalog.dart';

class BrandsRepository
    extends IRepository<Brand, BrandFilter, IBrandDataSource> {
  BrandsRepository({
    required FetchPolicies policies,
    required IBrandDataSource local,
    required IBrandDataSource remote,
  }) : super(policies: policies, local: local, remote: remote);

  @override
  Future<Brand?> getById(String id) async {
    return remote.getById(id);
  }

  @override
  Future<List<Brand>> list(BrandFilter filter) {
    return remote.list(filter);
  }

  @override
  Future<bool> remove(String id) {
    return remote.remove(id);
  }

  @override
  Future<bool> save(Brand entity, {ImageUpdateParam? updateParam}) async {
    return remote.save(entity, updateParam: updateParam);
  }

  @override
  Stream<Brand> stream(BrandFilter filter) {
    // TODO: implement stream
    throw UnimplementedError();
  }
}
