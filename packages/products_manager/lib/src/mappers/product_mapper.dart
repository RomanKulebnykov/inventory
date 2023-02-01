import 'package:domain_models/domain_models.dart';
import 'package:file_helpers/file_helpers.dart';

import '../firestore/models/product_model.dart';

extension ModelToDomain on ProductModel {
  Product toProduct({
    required ImageData image,
    String? barCode,
    Brand? brend,
  }) {
    return Product(
      id: id,
      title: title,
      code: code,
      entryPrice: entryPrice,
      sellingPrice: sellingPrice,
      articles: articles,
      description: description,
      lastUpdate: lastUpdate,
      image: image,
      barCode: barCode,
      brend: brend,
    );
  }
}

extension DomainToModel on Product {
  ProductModel toProductModel() {
    return ProductModel(
      id: id,
      title: title,
      code: code,
      articles: articles,
      entryPrice: entryPrice,
      sellingPrice: sellingPrice,
      description: description,
      lastUpdate: lastUpdate,
      barCode: barCode,
      brendId: brend?.id,
      imagePath: image?.imagePath,
    );
  }
}
