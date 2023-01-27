import 'package:products_manager/products_manager.dart';
import 'package:products_manager/src/repositories/mappers/product_mapper.dart';
import 'package:products_manager/src/repositories/models/product_model.dart';

import '../repositories/models/brand_model.dart';

class FirestoreProductManager extends ProductsManager {
  final FirestoreProductRepository productsRepository;
  final FirestoreBrendRepository brendRepository;

  FirestoreProductManager({
    required this.productsRepository,
    required this.brendRepository,
  });

  @override
  Future<Product> getProduct(String id) async {
    final productM = await productsRepository.getProduct(id);
    return _createDomainProduct(productM);
  }

  Future<Product> _createDomainProduct(ProductModel productM) async {
    final BrandModel? brandM;
    final String? imageUrl;
    if (productM.brendId != null) {
      brandM = await brendRepository.getBrendById(productM.brendId!);
    }
    if (productM.imagePath != null) {
      /// TODO: GetImage
    }
    return productM.toProduct(/****/);
  }

  Future<Brend> _createDomainBrand(BrandModel brendM) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<void> addProduct(Product product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Brend> getBrendById(String id) {
    // TODO: implement getBrendById
    throw UnimplementedError();
  }

  @override
  Future<void> saveBrend(Brend brend) {
    // TODO: implement saveBrend
    throw UnimplementedError();
  }
}
