import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ProductsRepository {
  final FirebaseFirestore firestore;
  CollectionReference<Map<String, dynamic>> get _productsCollection =>
      firestore.collection('products');

  ProductsRepository(this.firestore);

  Future<void> addProduct(Product product) async {
    await _productsCollection.doc(product.id).set(product.toMap());
  }

  Future<void> deleteProduct(String productId) async {
    await _productsCollection.doc(productId).delete();
  }

  Future<List<Product>> getProducts() async {
    final snapshot = await _productsCollection.get();
    return snapshot.docs.map((e) => Product.fromMap(e.data())).toList();
  }
}
