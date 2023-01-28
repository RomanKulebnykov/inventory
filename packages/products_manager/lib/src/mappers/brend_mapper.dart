import 'package:products_manager/products_manager.dart';

import '../firestore/models/brand_model.dart';

extension ModelToDomain on BrandModel {
  Brand toBrandDomain({String? logoImageUrl}) {
    return Brand(
      id: id,
      name: name,
      description: description,
      logoImagePath: logoImagePath,
      logImageURL: logoImageUrl,
    );
  }
}

extension DomainToModel on Brand {
  BrandModel toBrandModel() {
    return BrandModel(
      id: id,
      name: name,
      description: description,
      logoImagePath: logoImagePath,
    );
  }
}
