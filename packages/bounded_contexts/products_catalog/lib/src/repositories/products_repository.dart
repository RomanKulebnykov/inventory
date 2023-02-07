import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

abstract class ProductsRepository extends IRepository<Product, ProductFilter> {
  @override
  Future<Product> getById(String id);

  @override
  Future<List<Product>> list(ProductFilter filter);

  @override
  Stream<Product> stream(ProductFilter filter);

  @override
  Future<bool> remove(String id);

  @override
  Future<bool> save(Product entity);
}

class ProductFilter extends IEntityFilter {}
