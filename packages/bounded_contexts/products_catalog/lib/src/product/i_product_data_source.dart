import 'package:shared_kernel/shared_kernel.dart';

import 'product_entity/product.dart';
import 'product_filter.dart';

abstract class IProductDataSource extends IDataSource<Product, ProductFilter> {
  @override
  Future<bool> save(Product entity, {ImageUpdateParam? updateParam});
}
