import 'package:products_manager/products_manager.dart';
import 'package:products_manager/src/firestore/repositories/firestore_product_repository.dart';

import 'repositories/firestore_brend_repository.dart';

class FirestoreProductManager extends ProductsManager {
  final FirestoreProductRepository productsRepository;
  final FirestoreBrendRepository brendRepository;

  FirestoreProductManager({
    required this.productsRepository,
    required this.brendRepository,
  });
}
