import 'package:shared_kernel/shared_kernel.dart';

class Product extends IAggregateRoot {
  final String title;
  final String code;
  final List<String> articles;
  final double entryPrice;
  final double sellingPrice;
  final String? description;
  final DateTime lastUpdate;
  final String? barCode;
  final String? brandId;
  final ImageData? image;

  const Product(
    super.id, {
    required this.title,
    required this.code,
    required this.entryPrice,
    required this.sellingPrice,
    required this.articles,
    required this.lastUpdate,
    this.description,
    required this.image,
    this.barCode,
    this.brandId,
  });

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [
        super.props,
        title,
        code,
        entryPrice,
        sellingPrice,
        articles,
        lastUpdate,
        description,
        image,
        barCode,
        brandId,
      ];
}
