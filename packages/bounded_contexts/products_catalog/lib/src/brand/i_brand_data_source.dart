import 'package:shared_kernel/shared_kernel.dart';

import '../../products_catalog.dart';

abstract class IBrandDataSource extends IDataSource<Brand, BrandFilter> {
  @override
  Future<bool> save(Brand entity, {ImageUpdateParam? updateParam});

  @override
  Future<bool> remove(String id);
}
