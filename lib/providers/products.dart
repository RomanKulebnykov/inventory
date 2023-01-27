import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';
import '../repositories/products_repository.dart';

class Products extends ChangeNotifier {
  factory Products.read(BuildContext context) => context.read<Products>();
  factory Products.watch(BuildContext context) => context.watch<Products>();

  Products(this._repository) {
    _repository.getProducts().then((value) {
      _products = value;
      notifyListeners();
    });
  }

  final ProductsRepository _repository;

  List<Product> _products = [];
  List<Product> get items => [..._products];

  int get count => _products.length;

  Future<void> _updateProductList() async {
    _products = await _repository.getProducts();
    notifyListeners();
  }

  Future<void> addProduct({
    required Product newProduct,
  }) async {
    await _repository.addProduct(newProduct);
    await _updateProductList();
  }
}
