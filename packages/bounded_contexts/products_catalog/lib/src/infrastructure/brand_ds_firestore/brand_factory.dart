import 'package:products_catalog/src/infrastructure/brand_ds_firestore/brand_model.dart';
import 'package:shared_kernel/shared_kernel.dart';

import '../../../products_catalog.dart';

class BrandFactory {
  static Brand create({required BrandModel model, required ImageData image}) {
    return Brand(
      model.id,
      name: model.name,
      description: model.description,
      image: image,
    );
  }
}
