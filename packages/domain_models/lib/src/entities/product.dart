import 'package:file_helpers/file_helpers.dart';

import 'brand.dart';
import 'i_product.dart';

class Product extends IProduct {
  final String? barCode;
  final Brand? brend;
  final ImageData image;

  const Product({
    required super.id,
    required super.title,
    required super.code,
    required super.entryPrice,
    required super.sellingPrice,
    required super.articles,
    required super.lastUpdate,
    super.description,
    required this.image,
    this.barCode,
    this.brend,
  });

  @override
  List<Object?> get props => [
        super.props,
      ];
}
