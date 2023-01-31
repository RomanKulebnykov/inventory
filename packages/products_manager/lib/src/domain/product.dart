import 'dart:typed_data';

import 'package:products_manager/src/domain/brand.dart';

import 'i_product.dart';

class Product extends IProduct {
  final String? barCode;
  final Brand? brend;
  final ItemImage? image;
  const Product({
    required super.id,
    required super.title,
    required super.code,
    required super.entryPrice,
    required super.sellingPrice,
    required super.articles,
    required super.lastUpdate,
    super.description,
    this.image,
    this.barCode,
    this.brend,
  });

  @override
  List<Object?> get props => [
        super.props,
        barCode,
        brend,
      ];
}

class ItemImage {
  final String name;
  final String extension;
  final Uint8List? bytes;
  final String? imageUrl;
  final String? imagePath;

  ItemImage({
    required this.name,
    required this.bytes,
    required this.extension,
    this.imageUrl,
    this.imagePath,
  });
}
