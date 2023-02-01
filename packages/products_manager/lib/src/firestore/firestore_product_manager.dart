import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain_models/domain_models.dart';
import 'package:file_helpers/file_helpers.dart';
import 'package:products_manager/products_manager.dart';

import 'models/brand_model.dart';
import 'models/product_model.dart';

class FirestoreProductManager extends ProductsManager {
  late final FirestoreProductRepository productsRepository;
  late final FirestoreBrendRepository brendRepository;

  /// -------------------------------------------------------------- Constructor
  FirestoreProductManager({
    required final CollectionReference<Map<String, dynamic>> Function()
        getBrendsCollectionPath,
    required final CollectionReference<Map<String, dynamic>>
            Function<T extends IProduct>()
        getProductCollectionPath,
  }) {
    brendRepository = FirestoreBrendRepository(
      getBrendsCollectionPath: getBrendsCollectionPath,
    );
    productsRepository = FirestoreProductRepository(
      getProductCollectionPath: getProductCollectionPath,
    );
  }

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
        extension: 'extension',
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

  /// --------------------------------------------------------------- getProduct
  @override
  Future<Product> getProduct(String id) async {
    final productM = await productsRepository.getProduct(id);
    return _createDomainProduct(productM);
  }

  /// -------------------------------------------------------------- getProducts
  @override
  Future<List<Product>> getProducts() async {
    final productsM = await productsRepository.getProducts();
    return Future.wait(
      productsM.map((productM) => _createDomainProduct(productM)),
    );
  }

  /// --------------------------------------------------------------- addProduct
  @override
  Future<void> saveProduct(Product product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  /// ------------------------------------------------------------ deleteProduct
  @override
  Future<void> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  /// ------------------------------------------------------------- getBrendById
  @override
  Future<Brand> getBrendById(String id) {
    // TODO: implement getBrendById
    throw UnimplementedError();
  }

  /// ---------------------------------------------------------------- saveBrend
  @override
  Future<void> saveBrend(Brand brend) {
    // TODO: implement saveBrend
    throw UnimplementedError();
  }
}
