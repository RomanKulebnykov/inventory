import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/brand_model.dart';

class FirestoreBrendRepository {
  final CollectionReference<Map<String, dynamic>> Function()
      getBrendsCollectionPath;

  FirestoreBrendRepository({required this.getBrendsCollectionPath});

  Future<BrandModel> getBrendById(String id) async {
    final snap = await brandConverter.doc(id).get();
    return snap.data()!;
  }

  Future<void> saveBrend(BrandModel brend) async {
    brandConverter.doc(brend.id).set(brend);
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
