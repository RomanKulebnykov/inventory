import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/models/resizable_table_persistance_impl.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:resizable_table/resizable_table.dart';

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
  final ResizableTablePersistance persistance = PersistanceMemory('nnnn');

  /// -------------------------------------------------------------- Constructor
  ProductsCatalogBloc(this.repository) : super(ProductsCatalogInitial()) {
    /// ProductsCatalogReloadProductsEvent
    on<ProductsCatalogReloadProductsEvent>((event, emit) async {
      emit(ProductsCatalogLoad());
      final products = await repository.list(ProductFilter());
      emit(ProductsCatalogShowProducts(
        productsList: products,
        resizableTablePersistance: persistance,
      ));
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
