import 'package:products_catalog/src/product/i_product_data_source.dart';
import 'package:shared_kernel/shared_kernel.dart';

import 'product_entity/product.dart';
import 'product_filter.dart';

class ProductsRepository
    extends IRepository<Product, ProductFilter, IProductDataSource> {
  ProductsRepository({
    required FetchPolicies policies,
    required IProductDataSource local,
    required IProductDataSource remote,
  }) : super(policies: policies, local: local, remote: remote);

  @override
  Future<Product?> getById(String id) {
    return remote.getById(id);
  }

  @override
  Future<List<Product>> list(ProductFilter filter) {
    return remote.list(filter);
  }

  @override
  Future<bool> remove(String id) {
    return remote.remove(id);
  }

  @override
  Future<bool> save(Product entity, {ImageUpdateParam? updateParam}) async {
    return remote.save(entity, updateParam: updateParam);
  }

  @override
  Stream<Product> stream(ProductFilter filter) {
    // TODO: implement stream
    throw UnimplementedError();
  }
}
