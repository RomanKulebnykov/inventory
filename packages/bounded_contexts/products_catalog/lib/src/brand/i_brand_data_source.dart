import 'package:products_catalog/src/product/product_filter.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../../products_catalog.dart';
import '../product/product_entity/product.dart';
import 'brand_entity/brand.dart';

abstract class IBrandDataSource extends IDataSource<Brand, BrandFilter> {
  @override
  Future<bool> save(Brand entity, {ImageUpdateParam? updateParam});

  @override
  Future<bool> remove(String id);
}
