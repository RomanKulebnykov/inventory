import 'package:equatable/equatable.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

class ProductPresentation extends Equatable {
  final String id;
  final String title;
  final String code;
  final List<String> articles;
  final double entryPrice;
  final double sellingPrice;
  final String? description;
  final DateTime lastUpdate;
  final String? barCode;
  final Brand? brand;
  final ImageData? image;

  Product get toProduct {
    return Product(
      id,
      title: title,
      code: code,
      entryPrice: entryPrice,
      sellingPrice: sellingPrice,
      articles: articles,
      lastUpdate: lastUpdate,
      image: image,
      barCode: barCode,
      description: description,
      brandId: brand?.id,
    );
  }

  ProductPresentation.fromProduct({
    required Product product,
    this.brand,
  })  : id = product.id,
        title = product.title,
        code = product.code,
        articles = product.articles,
        entryPrice = product.entryPrice,
        sellingPrice = product.sellingPrice,
        description = product.description,
        lastUpdate = product.lastUpdate,
        barCode = product.barCode,
        image = product.image;

  @override
  List<Object?> get props => [
        title,
        code,
        entryPrice,
        sellingPrice,
        articles,
        lastUpdate,
        description,
        image,
        barCode,
        brand,
      ];
}
