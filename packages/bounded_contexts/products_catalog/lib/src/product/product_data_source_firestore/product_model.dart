class ProductModel {
  final String id;
  final String title;
  final String code;
  final List<String> articles;
  final double entryPrice;
  final double sellingPrice;
  final String? description;
  final DateTime lastUpdate;
  final String? barCode;
  final String? brendId;
  final bool hasStoredLogoImage;

  const ProductModel({
    required this.id,
    required this.title,
    required this.code,
    required this.articles,
    required this.entryPrice,
    required this.sellingPrice,
    required this.lastUpdate,
    this.description,
    this.barCode,
    this.brendId,
    this.hasStoredLogoImage = false,
  });
}
