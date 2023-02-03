import 'package:domain_models/domain_models.dart';
import 'package:file_helpers/file_helpers.dart';

import '../models/brand_model.dart';

extension ModelToDomain on BrandModel {
  Brand toBrandDomain({required ImageData image}) {
    return Brand(
      id: id,
      name: name,
      description: description,
      image: image,
    );
  }
}

extension DomainToModel on Brand {
  BrandModel toBrandModel() {
    return BrandModel(
      id: id,
      name: name,
      description: description,
      logoImagePath: image.imagePath,
    );
  }
}
