import 'i_product_basic.dart';

class Product extends ProductBasic {
  final List<String> article;
  final String? barCode;
  final String? imageUrl;
  final String? brendName;
  final double entryPrice;
  final double sellingPrice;
  final String? description;

  const Product({
    required super.id,
    required super.title,
    required super.code,
    required this.article,
    required this.entryPrice,
    required this.sellingPrice,
    this.barCode,
    this.imageUrl,
    this.brendName,
    this.description,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        article,
        barCode,
        imageUrl,
        entryPrice,
        sellingPrice,
        description
      ];
}
