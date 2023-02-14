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

// extension ModelToDomain on ProductModel {
//   Product toProduct({
//     required ImageData image,
//     String? barCode,
//     Brand? brend,
//   }) {
//     return Product(
//       id: id,
//       title: title,
//       code: code,
//       entryPrice: entryPrice,
//       sellingPrice: sellingPrice,
//       articles: articles,
//       description: description,
//       lastUpdate: lastUpdate,
//       image: image,
//       barCode: barCode,
//       brend: brend,
//     );
//   }
// }
//
// extension DomainToModel on Product {
//   ProductModel toProductModel({
//     String? newPath,
//   }) {
//     return ProductModel(
//       id: id,
//       title: title,
//       code: code,
//       articles: articles,
//       entryPrice: entryPrice,
//       sellingPrice: sellingPrice,
//       description: description,
//       lastUpdate: lastUpdate,
//       barCode: barCode,
//       brendId: brend?.id,
//       imagePath: newPath ?? image?.imagePath,
//     );
//   }
// }
