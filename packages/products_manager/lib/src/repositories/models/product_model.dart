import 'i_product_basic.dart';

class ProductModel extends ProductBasic {
  final List<String> article;
  final String? barCode;
  final String? imagePath;
  final String? brendId;
  final double entryPrice;
  final double sellingPrice;
  final String? description;

  const ProductModel({
    required super.id,
    required super.title,
    required super.code,
    required this.article,
    required this.entryPrice,
    required this.sellingPrice,
    this.barCode,
    this.imagePath,
    this.brendId,
    this.description,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        article,
        barCode,
        imagePath,
        entryPrice,
        sellingPrice,
        description
      ];
}
