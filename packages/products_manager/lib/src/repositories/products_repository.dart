import '../models/product_model.dart';

abstract class ProductsRepository {
  Future<ProductModel> getProduct(String id);

  Future<List<ProductModel>> getProducts();

  Future<void> addProduct(ProductModel product);

  Future<void> deleteProduct(String productId);
}
