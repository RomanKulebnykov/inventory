part of 'products_catalog_bloc.dart';

/// ------------------------------------------------------- ProductsCatalogState
abstract class ProductsCatalogState extends Equatable {
  const ProductsCatalogState();
  @override
  List<Object> get props => [];
}

/// ----------------------------------------------------- ProductsCatalogInitial
class ProductsCatalogInitial extends ProductsCatalogState {}

/// -------------------------------------------------------- ProductsCatalogLoad
class ProductsCatalogLoad extends ProductsCatalogState {}

/// ------------------------------------------------ ProductsCatalogShowProducts
class ProductsCatalogShowProducts extends ProductsCatalogState {
  const ProductsCatalogShowProducts({
    required this.productsList,
    required this.resizableTablePersistance,
  });
  final List<ProductPresentation> productsList;
  final ResizableTablePersistance resizableTablePersistance;
}

/// ------------------------------------------------- ProductsCatalogEditProduct
class ProductsCatalogEditProduct extends ProductsCatalogState {
  const ProductsCatalogEditProduct({this.editedProduct});
  final Product? editedProduct;
}
