import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:products_catalog/src/infrastructure/brand_ds_firestore/brand_factory.dart';
import 'package:shared_kernel/shared_kernel.dart';

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
  Future<ImageData> _getImageData(String id, bool hasStoredImage) async {
    ImageData imageData;
    if (hasStoredImage) {
      final logoRef = _getLogoPath(id);
      final logoUrl = await _getLogoURL(logoRef);
      imageData = ImageData(status: ImageStatus.normal, imageURL: logoUrl);
    } else {
      imageData = ImageData(status: ImageStatus.empty);
    }
    return imageData;
  }
}

/// =================================================== BrandDataSourceFirestore
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

  /// ------------------------------------------------------------------ getById
  @override
  Future<Brand?> getById(String id) async {
    final brandSnap = await brandConverter.doc(id).get();
    final brandModel = brandSnap.data();
    if (brandModel == null) return null;

    final ImageData imageData = await _getImageData(
      brandModel.id,
      brandModel.hasStoredLogoImage,
    );
    return BrandFactory.create(model: brandModel, image: imageData);
  }

  Future<bool> _updateImage(String id, ImageData image) async {
    if (image.status == ImageStatus.removed) {
      await _getLogoPath(id).delete();
      return true;
    }
    if (image.status == ImageStatus.updated && image.bytes != null) {
      await _getLogoPath(id).putData(image.bytes!);
      return true;
    }
    return false;
  }

  /// --------------------------------------------------------------------- save
  @override
  Future<bool> save(Brand entity) async {
    await _updateImage(entity.id, entity.image);
    final brandModel = BrandFactory.convertToModel(entity);
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
