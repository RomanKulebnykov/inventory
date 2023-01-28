import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/i_product.dart';
import '../models/product_model.dart';

class FirestoreProductRepository {
  final CollectionReference<Map<String, dynamic>> Function<T extends IProduct>()
      getProductCollectionPath;

  /// -------------------------------------------------------------- Constructor
  FirestoreProductRepository({required this.getProductCollectionPath});

  /// --------------------------------------------------------------- getProduct
  Future<ProductModel> getProduct(String id) async {
    final snap = await productsConverter.doc(id).get();
    return snap.data()!;
  }

  /// --------------------------------------------------------------- getProduct
  Future<List<ProductModel>> getProducts() async {
    final snapshot = await productsConverter.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  /// --------------------------------------------------------------- addProduct
  Future<void> addProduct(ProductModel product) async {
    await productsConverter.doc(product.id).set(product);
  }

  /// ------------------------------------------------------------ deleteProduct
  Future<void> deleteProduct(String productId) async {
    await productsConverter.doc(productId).delete();
  }

  /// -------------------------------------------------------- productsConverter
  CollectionReference<ProductModel> get productsConverter {
    return getProductCollectionPath().withConverter(
      fromFirestore: (snapshot, options) {
        return ProductModel(
          id: snapshot['id'] as String,
          title: snapshot['title'] as String,
          code: snapshot['code'] as String,
          articles: List<String>.from(snapshot['article']),
          entryPrice: double.parse(snapshot['entryPrice'].toString()),
          sellingPrice: double.parse(snapshot['sellingPrice'].toString()),
          barCode: snapshot['barCode'] as String,
          imagePath: snapshot['imagePath'] as String,
          description: snapshot['description'] as String,
          brendId: snapshot['brendId'] as String?,
        );
      },
      toFirestore: (product, options) {
        return {
          'id': product.id,
          'title': product.title,
          'code': product.code,
          'article': product.articles,
          'entryPrice': product.entryPrice,
          'sellingPrice': product.sellingPrice,
          'barCode': product.barCode,
          'imagePath': product.imagePath,
          'brendId': product.brendId,
          'description': product.description,
        };
      },
    );
  }
}
