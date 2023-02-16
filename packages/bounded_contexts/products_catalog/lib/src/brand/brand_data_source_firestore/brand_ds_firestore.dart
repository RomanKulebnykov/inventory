import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_storage_firebase/file_storage_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../i_brand_data_source.dart';
import 'brand_factory.dart';
import 'brand_model.dart';

/// =================================================== BrandDataSourceFirestore
class BrandDataSourceFirestore extends IBrandDataSource {
  /// -------------------------------------------------------------- Constructor

  BrandDataSourceFirestore({
    required this.getBrendsCollectionPath,
    required Reference Function() getStorageFilesPath,
  }) : fileStorage = FileStorageFirebase(getStorageFilesPath);

  /// --------------------------------------------------------------- Properties
  final CollectionReference<Map<String, dynamic>> Function()
      getBrendsCollectionPath;

  final FileStorageFirebase fileStorage;

  /// ------------------------------------------------------------------ getById
  @override
  Future<Brand?> getById(String id) async {
    final brandSnap = await brandConverter.doc(id).get();
    final brandModel = brandSnap.data();

    if (brandModel == null) {
      return null;
    }
    ImageData? imageData;
    if (brandModel.hasStoredLogoImage) {
      imageData = await fileStorage.getLogoImage(brandModel.id);
    }
    return BrandFactory.create(model: brandModel, image: imageData);
  }

  /// --------------------------------------------------------------------- save
  @override
  Future<bool> save(Brand entity, {ImageUpdateParam? updateParam}) async {
    bool hasLogo = await fileStorage.updateLogoImage(
      entityId: entity.id,
      updateParam: updateParam,
    );

    final brandModel = BrandFactory.convertToModel(entity, hasLogo);
    await brandConverter.doc(entity.id).set(brandModel);
    return true;
  }

  Query<BrandModel> _queryFromFilter(BrandFilter filter) {
    /// Limit
    var query = brandConverter.limit(filter.limit);

    /// Name Starts
    if (filter.nameStarts != null) {
      query = query.where('name', isGreaterThan: filter.nameStarts);
    }
    return query;
  }

  /// --------------------------------------------------------------------- list
  @override
  Future<List<Brand>> list(BrandFilter filter) async {
    final brands = <Brand>[];
    final snap = await _queryFromFilter(filter).get();
    for (final doc in snap.docs) {
      final brandModel = doc.data();
      ImageData? imageData;
      if (brandModel.hasStoredLogoImage) {
        imageData = await fileStorage.getLogoImage(brandModel.id);
      }
      brands.add(BrandFactory.create(model: brandModel, image: imageData));
    }
    return brands;
  }

  /// ------------------------------------------------------------------- remove
  @override
  Future<bool> remove(String id) async {
    await fileStorage.updateLogoImage(
      entityId: id,
      updateParam: ImageUpdateParamRemove(),
    );
    await brandConverter.doc(id).delete();
    return true;
  }

  /// ----------------------------------------------------------- brandConverter
  CollectionReference<BrandModel> get brandConverter {
    return getBrendsCollectionPath().withConverter(
      fromFirestore: (snapshot, options) {
        return BrandModel(
          id: snapshot['id'] as String,
          name: snapshot['name'] as String,
          description: snapshot['description'] as String,
          hasStoredLogoImage: snapshot['hasStoredLogoImage'] as bool,
        );
      },
      toFirestore: (brand, options) {
        return {
          'id': brand.id,
          'name': brand.name,
          'description': brand.description,
          'hasStoredLogoImage': brand.hasStoredLogoImage,
        };
      },
    );
  }
}
