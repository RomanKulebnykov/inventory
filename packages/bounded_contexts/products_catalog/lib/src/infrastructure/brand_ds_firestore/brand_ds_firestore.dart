import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_storage_firebase/file_storage_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:products_catalog/src/infrastructure/brand_ds_firestore/brand_factory.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../../i_brand_data_source.dart';
import 'brand_model.dart';

/// ============================================ BrandDataSourceFirestoreHelpers
extension BrandDataSourceFirestoreHelpers on BrandDataSourceFirestore {
  /// ------------------------------------------------------------- _getLogoPath
  Reference _getLogoPath(String brendId) {
    return getStorageFilesPath().child(brendId).child('logo.jpg');
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
}

/// =================================================== BrandDataSourceFirestore
class BrandDataSourceFirestore extends IBrandDataSource {
  /// -------------------------------------------------------------- Constructor

  BrandDataSourceFirestore({
    required this.getBrendsCollectionPath,
    required this.getStorageFilesPath,
  });

  /// --------------------------------------------------------------- Properties
  final CollectionReference<Map<String, dynamic>> Function()
      getBrendsCollectionPath;

  final Reference Function() getStorageFilesPath;

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
      imageData = await _getImageData(brandModel.id);
    }

    return BrandFactory.create(model: brandModel, image: imageData);
  }

  /// --------------------------------------------------------------------- save
  @override
  Future<bool> save(Brand entity, {ImageUpdateParam? updateParam}) async {
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

    final brandModel = BrandFactory.convertToModel(entity, hasLogo);
    await brandConverter.doc(entity.id).set(brandModel);
    return true;
  }

  /// --------------------------------------------------------------------- list
  @override
  Future<List<Brand>> list(BrandFilter filter) async {
    final brands = <Brand>[];
    final snap = await brandConverter.get();
    for (final doc in snap.docs) {
      final brandModel = doc.data();
      ImageData? imageData;
      if (brandModel.hasStoredLogoImage) {
        imageData = await _getImageData(brandModel.id);
      }
      brands.add(BrandFactory.create(model: brandModel, image: imageData));
    }
    return brands;
  }

  /// ------------------------------------------------------------------- remove
  @override
  Future<bool> remove(String id) async {
    await FileStorageFirebase.deleteFile(_getLogoPath(id));
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
