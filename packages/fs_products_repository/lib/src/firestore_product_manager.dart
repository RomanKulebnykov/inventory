import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_storage_repository/data_storage_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:file_helpers/file_helpers.dart';
import 'package:fs_products_repository/src/mappers/product_mapper.dart';

import '../fs_products_repository.dart';
import 'models/brand_model.dart';
import 'models/product_model.dart';

part 'firestore_product_manager_helper.dart';

typedef CollRef = CollectionReference<Map<String, dynamic>>;

class FirestoreProductManager extends ProductsRepository {
  /// -------------------------------------------------------------- Constructor
  FirestoreProductManager({
    required this.storageRepository,
    required final CollRef Function() getBrendsCollectionPath,
    required final CollRef Function<T extends IProduct>()
        getProductCollectionPath,
  }) {
    brendRepository = FirestoreBrendRepository(
      getBrendsCollectionPath: getBrendsCollectionPath,
    );
    productsRepository = FirestoreProductRepository(
      getProductCollectionPath: getProductCollectionPath,
    );
  }

  late final FirestoreProductRepository productsRepository;
  late final FirestoreBrendRepository brendRepository;
  final DataStorageRepository storageRepository;

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
  Future<void> saveProduct(Product product) async {
    final image = product.image;
    if (image != null && image.data != null) {
      final newPath = await storageRepository.updateProductImage(image);
    }
    await productsRepository.saveProduct(product.toProductModel());
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

  @override
  Future<void> deleteBrand(String id) {
    // TODO: implement deleteBrand
    throw UnimplementedError();
  }

  @override
  Future<List<Brand>> getBrands() {
    // TODO: implement getBrands
    throw UnimplementedError();
  }
}
