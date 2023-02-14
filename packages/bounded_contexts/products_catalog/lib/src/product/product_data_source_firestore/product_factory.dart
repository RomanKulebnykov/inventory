import 'package:shared_kernel/shared_kernel.dart';

import '../product_entity/product.dart';
import 'product_model.dart';

class ProductFactory {
  ProductFactory._internal();
  static Product create({required ProductModel model, ImageData? image}) {
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
      image: image,
    );
  }

  static ProductModel convertToModel(Product product, bool hasStoredLogoImage) {
    return ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      code: product.code,
      articles: product.articles,
      entryPrice: product.entryPrice,
      sellingPrice: product.entryPrice,
      barCode: product.barCode,
      brendId: product.brandId,
      lastUpdate: product.lastUpdate,
      hasStoredLogoImage: hasStoredLogoImage,
    );
  }
}
