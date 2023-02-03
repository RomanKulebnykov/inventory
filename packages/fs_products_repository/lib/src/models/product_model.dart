import 'package:domain_models/domain_models.dart';

class ProductModel extends IProduct {
  final String? barCode;
  final String? brendId;
  final String? imagePath;

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
    this.imagePath,
    this.brendId,
  });

  @override
  List<Object?> get props => [
        super.props,
        barCode,
        brendId,
        imagePath,
      ];
}
