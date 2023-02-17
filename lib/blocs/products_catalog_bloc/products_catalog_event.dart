part of 'products_catalog_bloc.dart';

abstract class ProductsCatalogEvent extends Equatable {
  const ProductsCatalogEvent();

  @override
  List<Object?> get props => [];
}

class ProductsCatalogReloadProductsEvent extends ProductsCatalogEvent {}

class ProductsCatalogAddNewProductEvent extends ProductsCatalogEvent {}

class ProductsCatalogEditProductEvent extends ProductsCatalogEvent {
  const ProductsCatalogEditProductEvent(this.product);

  final Product product;

  @override
  List<Object?> get props => [super.props, product];
}
