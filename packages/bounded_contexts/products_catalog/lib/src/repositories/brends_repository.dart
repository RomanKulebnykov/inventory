import 'package:shared_kernel/shared_kernel.dart';

import '../../products_catalog.dart';

abstract class BrandsRepository extends IRepository<Brand, BrandFilter> {
  @override
  Future<Brand> getById(String id);

  @override
  Future<List<Brand>> list(BrandFilter filter);

  @override
  Stream<Brand> stream(BrandFilter filter);

  @override
  Future<bool> remove(String id);

  @override
  Future<bool> save(Brand entity);
}

class BrandFilter implements IEntityFilter {
  //
}
