part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

/// ---------------------------------------------------------- ProductsInSuccess
class ProductsSuccess extends ProductsState {
  const ProductsSuccess(this._products);
  final List<Product> _products;
  List<Product> get items => [..._products];

  int get count => _products.length;
  @override
  List<Object?> get props => [_products];
}

/// --------------------------------------------------------- ProductsInProgress
class ProductsInProgress extends ProductsState {
  @override
  List<Object?> get props => [];
}

/// ------------------------------------------------------------ ProductsFailure
class ProductsFailure extends ProductsState {
  final String msg;

  const ProductsFailure(this.msg);
  @override
  List<Object?> get props => [msg];
}
