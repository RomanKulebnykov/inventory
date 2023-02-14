import 'package:shared_kernel/shared_kernel.dart';

import '../brand_entity/brand.dart';
import 'brand_model.dart';

class BrandFactory {
  BrandFactory._internal();
  static Brand create({required BrandModel model, ImageData? image}) {
    return Brand(
      model.id,
      name: model.name,
      description: model.description,
      image: image,
    );
  }

  static BrandModel convertToModel(Brand brand, bool hasStoredLogoImage) {
    return BrandModel(
      id: brand.id,
      name: brand.name,
      description: brand.description,
      hasStoredLogoImage: hasStoredLogoImage,
    );
  }
}
