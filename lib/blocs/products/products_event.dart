part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class UpdateListOfProductsEvent extends ProductsEvent {
  @override
  List<Object?> get props => [];
}

class SaveProductEvent extends ProductsEvent {
  final Product product;

  const SaveProductEvent(this.product);
  @override
  List<Object?> get props => [product];
}
