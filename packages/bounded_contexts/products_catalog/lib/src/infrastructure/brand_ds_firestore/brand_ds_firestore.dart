import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:products_catalog/src/infrastructure/brand_ds_firestore/brand_factory.dart';
import 'package:shared_kernel/shared_kernel.dart';

import 'brand_model.dart';

class BrandDataSourceFirestore extends IDataSource<Brand, BrandFilter> {
  /// -------------------------------------------------------------- Constructor

  BrandDataSourceFirestore({
    required this.getBrendsCollectionPath,
    required this.getStorageFilesPath,
  });

  /// --------------------------------------------------------------- Properties
  final CollectionReference<Map<String, dynamic>> Function()
      getBrendsCollectionPath;

  final Reference Function() getStorageFilesPath;

  @override
  Future<Brand?> getById(String id) async {
    final brandSnap = await brandConverter.doc(id).get();
    final brandModel = brandSnap.data();
    if (brandModel == null) return null;
    if (brandModel.logoImagePath != null) {
      /// TODO: get image data
      UnimplementedError();
      final imageData = ImageData();
      BrandFactory.create(model: brandModel, image: imageData);
    }
    return BrandFactory.create(model: brandModel, image: ImageData());
  }

  @override
  Future<bool> save(Brand entity) async {
    print(entity.image);

    return false;
  }

  @override
  Future<List<Brand>> list(BrandFilter filter) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  CollectionReference<BrandModel> get brandConverter {
    return getBrendsCollectionPath().withConverter(
      fromFirestore: (snapshot, options) {
        return BrandModel(
          id: snapshot['id'] as String,
          name: snapshot['name'] as String,
          description: snapshot['description'] as String,
          logoImagePath: snapshot['logoImagePath'] as String?,
        );
      },
      toFirestore: (brand, options) {
        return {
          'id': brand.id,
          'name': brand.name,
          'description': brand.description,
          'logoImagePath': brand.logoImagePath,
        };
      },
    );
  }
}
