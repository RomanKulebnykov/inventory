import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_catalog/products_catalog.dart';

part 'products_catalog_event.dart';
part 'products_catalog_state.dart';

class ProductsCatalogBloc
    extends Bloc<ProductsCatalogEvent, ProductsCatalogState> {
  /// -------------------------------------------------------- Bloc acces helper
  static addEvent(BuildContext context, ProductsCatalogEvent event) {
    context.read<ProductsCatalogBloc>().add(event);
  }

  /// --------------------------------------------------------------- Properties
  final ProductsRepository repository;

  /// -------------------------------------------------------------- Constructor
  ProductsCatalogBloc(this.repository) : super(ProductsCatalogInitial()) {
    /// ProductsCatalogReloadProductsEvent
    on<ProductsCatalogReloadProductsEvent>((event, emit) async {
      emit(ProductsCatalogLoad());
      final products = await repository.list(ProductFilter());
      emit(ProductsCatalogShowProducts(productsList: products));
    });

    /// ProductsCatalogAddNewProductEvent
    on<ProductsCatalogAddNewProductEvent>((event, emit) {
      emit(const ProductsCatalogEditProduct());
    });

    /// ProductsCatalogEditProductEvent
    on<ProductsCatalogEditProductEvent>((event, emit) {
      emit(ProductsCatalogEditProduct(editedProduct: event.product));
    });

    add(ProductsCatalogReloadProductsEvent());
  }
}
