import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:products_catalog/src/infrastructure/brand_ds_firestore/brand_factory.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../../i_brand_data_source.dart';
import 'brand_model.dart';

/// ============================================ BrandDataSourceFirestoreHelpers
extension BrandDataSourceFirestoreHelpers on BrandDataSourceFirestore {
  /// -------------------------------------------------------------- _getLogoURL
  Future<String?> _getLogoURL(Reference ref) async {
    try {
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  /// ------------------------------------------------------------- _getLogoPath
  Reference _getLogoPath(String brendId) {
    return getStorageFilesPath().child(brendId).child('logo.jpg');
  }

  /// ------------------------------------------------------------ _getImageData
  Future<ImageData?> _getImageData(String id) async {
    final logoRef = _getLogoPath(id);
    final logoUrl = await _getLogoURL(logoRef);
    final imageData = ImageData(imageURL: logoUrl);

    return imageData;
  }

  Future<bool> _updateImage(
    String id,
    ImageData image,
    ImageStatus imageStatus,
  ) async {
    switch (imageStatus) {
      case ImageStatus.removed:
        await _getLogoPath(id).delete();
        break;
      case ImageStatus.updated:
        await _getLogoPath(id).putData(image.bytes!);
        break;
      case ImageStatus.normal:
        break;
    }
    return true;
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
  Future<bool> save(Brand entity, {ImageStatus? imageStatus}) async {
    if (imageStatus != null && imageStatus != ImageStatus.normal) {
      await _updateImage(entity.id, entity.image!, imageStatus);
    }
    final brandModel = BrandFactory.convertToModel(entity, false);
    await brandConverter.doc(entity.id).set(brandModel);
    return true;
  }

  /// --------------------------------------------------------------------- list
  @override
  Future<List<Brand>> list(BrandFilter filter) {
    // TODO: implement list
    throw UnimplementedError();
  }

  /// ------------------------------------------------------------------- remove
  @override
  Future<bool> remove(String id) {
    // TODO: implement remove
    throw UnimplementedError();
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
