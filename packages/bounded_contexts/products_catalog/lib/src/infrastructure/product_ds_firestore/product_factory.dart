import 'package:products_catalog/src/entities/product/product.dart';
import 'package:shared_kernel/shared_kernel.dart';

import 'product_model.dart';

class ProductFactory {
  static Product create({
    required ProductModel model,
    ImageData? image,
  }) {
    return Product(
      model.id,
      title: model.title,
      code: model.code,
      entryPrice: model.entryPrice,
      sellingPrice: model.sellingPrice,
      articles: model.articles,
      lastUpdate: model.lastUpdate,
      description: model.description,
      barCode: model.barCode,
      brandId: model.brendId,
      image: image ?? ImageData(),
    );
  }
}
