import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_storage_firebase/file_storage_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:products_catalog/src/product/i_product_data_source.dart';
import 'package:products_catalog/src/product/product_data_source_firestore/product_factory.dart';

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

  /// ------------------------------------------------------------- _getLogoPath
  Reference _getLogoPath(String productId) {
    return getStorageFilesPath().child(productId).child('logo.jpg');
  }

  /// ------------------------------------------------------------ _getImageData
  Future<ImageData?> _getImageData(String id) async {
    try {
      final logoRef = _getLogoPath(id);
      final logoUrl = await FileStorageFirebase.getFileURL(logoRef);
      return ImageData(imageURL: logoUrl);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product?> getById(String id) async {
    final productSnap = await productsConverter.doc(id).get();
    final productModel = productSnap.data();
    if (productModel == null) return null;

    ImageData? imageData;
    if (productModel.hasStoredLogoImage) {
      imageData = await _getImageData(productModel.id);
    }

    return ProductFactory.create(model: productModel, image: imageData);
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
  Future<bool> save(Product entity, {ImageUpdateParam? updateParam}) async {
    bool hasLogo = entity.image?.imageURL != null;
    if (updateParam is ImageUpdateParamReplace) {
      await FileStorageFirebase.saveFile(
        _getLogoPath(entity.id),
        updateParam.bytes,
      );
      hasLogo = true;
    } else if (updateParam is ImageUpdateParamDelete) {
      await FileStorageFirebase.deleteFile(_getLogoPath(entity.id));
      hasLogo = false;
    }

    final productModel = ProductFactory.convertToModel(entity, hasLogo);
    await productsConverter.doc(entity.id).set(productModel);
    return true;
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
          lastUpdate: snapshot['imagePath'].toDate(),
          description: snapshot['description'] as String,
          brendId: snapshot['brendId'] as String?,
          hasStoredLogoImage: ['hasStoredLogoImage'] as bool,
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
          'lastUpdate': product.lastUpdate,
          'description': product.description,
          'brendId': product.brendId,
          'hasStoredLogoImage': product.hasStoredLogoImage,
        };
      },
    );
  }
}
