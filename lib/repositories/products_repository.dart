import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ProductsRepository {
  final FirebaseFirestore firestore;
  CollectionReference<Map<String, dynamic>> get _productsCollection =>
      firestore.collection('products');

  ProductsRepository(this.firestore);

  Future<void> addProduct(Product product) async {
    await productsConverter.doc(product.id).set(product);
  }

  Future<void> deleteProduct(String productId) async {
    await productsConverter.doc(productId).delete();
  }

  Future<List<Product>> getProducts() async {
    final snapshot = await productsConverter.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  CollectionReference<Product> get productsConverter {
    return _productsCollection.withConverter(
      fromFirestore: (snapshot, options) {
        return Product(
          id: snapshot['id'] as String,
          title: snapshot['title'] as String,
          code: snapshot['code'] as String,
          article: List<String>.from(snapshot['article']),
          entryPrice: double.parse(snapshot['entryPrice'].toString()),
          sellingPrice: double.parse(snapshot['sellingPrice'].toString()),
          barCode: snapshot['barCode'] as String,
          imageUrl: snapshot['imageUrl'] as String,
          description: snapshot['description'] as String,
          brendName: snapshot['brendName'] as String?,
        );
      },
      toFirestore: (product, options) {
        return {
          'id': product.id,
          'title': product.title,
          'code': product.code,
          'article': product.article,
          'entryPrice': product.entryPrice,
          'sellingPrice': product.sellingPrice,
          'barCode': product.barCode,
          'imageUrl': product.imageUrl,
          'brendName': product.brendName,
          'description': product.description,
        };
      },
    );
  }
}
