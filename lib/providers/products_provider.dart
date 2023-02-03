import 'package:domain_models/domain_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:products_manager/fs_products_repository.dart';
import 'package:provider/provider.dart';

class ProductsProvider extends ChangeNotifier {
  factory ProductsProvider.read(BuildContext context) =>
      context.read<ProductsProvider>();
  factory ProductsProvider.watch(BuildContext context) =>
      context.watch<ProductsProvider>();

  ProductsProvider(this._productsManager) {
    _productsManager.getProducts().then((value) {
      _products = value;
      notifyListeners();
    });
  }

  final ProductsManager _productsManager;

  List<Product> _products = [];
  List<Product> get items => [..._products];

  int get count => _products.length;

  Future<void> _updateProductList() async {
    _products = await _productsManager.getProducts();
    notifyListeners();
  }

  Future<void> saveProduct({
    required Product newProduct,
  }) async {
    await _productsManager.saveProduct(newProduct);
    await _updateProductList();
  }
}
