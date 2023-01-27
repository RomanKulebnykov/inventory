import 'package:products_manager/products_manager.dart';
import 'package:products_manager/src/domain/brend.dart';
import 'package:products_manager/src/domain/product.dart';
import 'package:products_manager/src/firestore/repositories/firestore_product_repository.dart';

import 'repositories/firestore_brend_repository.dart';

class FirestoreProductManager extends ProductsManager {
  final FirestoreProductRepository productsRepository;
  final FirestoreBrendRepository brendRepository;

  FirestoreProductManager({
    required this.productsRepository,
    required this.brendRepository,
  });

  @override
  Future<Brend> getBrendById(String id) {
    // TODO: implement getBrendById
    throw UnimplementedError();
  }

  @override
  Future<void> saveBrend(Brend brend) {
    // TODO: implement saveBrend
    throw UnimplementedError();
  }

  @override
  Future<void> addProduct(Product product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProduct(String id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
