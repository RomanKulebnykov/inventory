part of 'products_catalog_bloc.dart';

abstract class ProductsCatalogState extends Equatable {
  const ProductsCatalogState();
}

class ProductsCatalogInitial extends ProductsCatalogState {
  @override
  List<Object> get props => [];
}
