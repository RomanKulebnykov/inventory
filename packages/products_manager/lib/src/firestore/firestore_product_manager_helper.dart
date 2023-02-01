part of 'firestore_product_manager.dart';

extension FirestoreProductManagerHelper on FirestoreProductManager {
  /// ----------------------------------------------------- _createDomainProduct
  Future<Product> _createDomainProduct(ProductModel productM) async {
    final BrandModel? brandM;
    final ImageData image;
    if (productM.brendId != null) {
      brandM = await brendRepository.getBrendById(productM.brendId!);
    }
    if (productM.imagePath != null) {
      image = ImageData(
        name: 'name',
        bytes: Uint8List.fromList([]),
      );

      /// TODO: GetImage
    } else {}
    throw UnimplementedError();
    // return productM.toProduct(image:image  /****/);
  }

  /// ------------------------------------------------------- _createDomainBrand
  Future<Brand> _createDomainBrand(BrandModel brendM) async {
    throw UnimplementedError();
  }
}
