import '../../domain/i_product.dart';

class ProductModel extends IProduct {
  final String? barCode;
  final String? brendId;

  const ProductModel({
    required super.id,
    required super.title,
    required super.code,
    required super.articles,
    required super.entryPrice,
    required super.sellingPrice,
    required super.lastUpdate,
    super.description,
    this.barCode,
    super.imagePath,
    this.brendId,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        barCode,
        brendId,
      ];
}
