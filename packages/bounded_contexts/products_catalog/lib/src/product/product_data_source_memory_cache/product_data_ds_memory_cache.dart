import 'package:products_catalog/src/product/i_product_data_source.dart';
import 'package:products_catalog/src/product/product_entity/product.dart';
import 'package:products_catalog/src/product/product_filter.dart';
import 'package:shared_kernel/src/models/image/edit_image_data.dart';

class ProductDataSourceMemoryCache extends IProductDataSource {
  @override
  Future<Product?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> list(ProductFilter filter) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> save(Product entity, {ImageUpdateParam? updateParam}) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
