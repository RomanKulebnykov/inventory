import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_manager/products_manager.dart';

import '../models/brand_model.dart';

class FirestoreBrendRepository {
  final CollectionReference<Map<String, dynamic>> Function()
      getBrendsCollectionPath;

  FirestoreBrendRepository({
    required this.getBrendsCollectionPath,
  });

  Future<BrandModel> getBrendById(String id) {
    // TODO: implement getBrendById
    throw UnimplementedError();
  }

  Future<void> saveBrend(BrandModel brend) {
    // TODO: implement saveBrend
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
