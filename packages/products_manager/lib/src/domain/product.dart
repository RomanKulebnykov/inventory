import 'package:products_manager/src/domain/brand.dart';

import '../firestore/models/i_product.dart';

class Product extends IProduct {
  final String? barCode;
  final String? imageURL;
  final Brand? brend;

  const Product({
    required super.id,
    required super.title,
    required super.code,
    required super.entryPrice,
    required super.sellingPrice,
    required super.articles,
    super.description,
    super.imagePath,
    this.barCode,
    this.imageURL,
    this.brend,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        barCode,
        imageURL,
        brend,
      ];
}
