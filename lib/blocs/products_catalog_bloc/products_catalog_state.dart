part of 'products_catalog_bloc.dart';

abstract class ProductsCatalogState extends Equatable {
  const ProductsCatalogState();
  @override
  List<Object> get props => [];
}

class ProductsCatalogInitial extends ProductsCatalogState {}

class ProductsCatalogLoad extends ProductsCatalogState {}

class ProductsCatalogShowProducts extends ProductsCatalogState {
  const ProductsCatalogShowProducts({required this.productsList});
  final List<Product> productsList;
}

class ProductsCatalogEditProduct extends ProductsCatalogState {
  const ProductsCatalogEditProduct({this.editedProduct});
  final Product? editedProduct;
}
