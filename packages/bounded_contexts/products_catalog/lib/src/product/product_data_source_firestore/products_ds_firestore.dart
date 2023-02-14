import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:products_catalog/src/product/i_product_data_source.dart';

import 'package:products_catalog/src/product/product_filter.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../product_entity/product.dart';
import 'product_model.dart';

class ProductDataSourceFirestore extends IProductDataSource {
  /// -------------------------------------------------------------- Constructor
  ProductDataSourceFirestore({
    required this.getProductCollectionPath,
    required this.getStorageFilesPath,
  });

  /// --------------------------------------------------------------- Properties
  final CollectionReference<Map<String, dynamic>> Function()
      getProductCollectionPath;

  final Reference Function() getStorageFilesPath;

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
          lastUpdate: snapshot['imagePath'].toDate(),
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
          'lastUpdate': product.lastUpdate,
          'description': product.description,
          'brendId': product.brendId,
        };
      },
    );
  }
}
