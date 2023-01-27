import 'domain/brend.dart';
import 'domain/product.dart';

abstract class ProductsManager {
  Future<Brend> getBrendById(String id);

  Future<void> saveBrend(Brend brend);

  Future<Product> getProduct(String id);

  Future<List<Product>> getProducts();

  Future<void> addProduct(Product product);

  Future<void> deleteProduct(String id);
}
