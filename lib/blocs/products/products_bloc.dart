import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_catalog/products_catalog.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  /// --------------------------------------------------- Helper Instance Getter
  factory ProductsBloc.of(BuildContext context) {
    return context.read<ProductsBloc>();
  }

  /// ---------------------------------------------------------- Helper addEvent
  static addEvent(BuildContext context, ProductsEvent event) {
    ProductsBloc.of(context).add(event);
  }

  /// ----------------------------------------------------------- Private Fields
  // final ProductsManager _productsManager;

  /// -------------------------------------------------------------- Constructor
  ProductsBloc() : super(ProductsInitial()) {
    if (state is ProductsInitial) add(UpdateListOfProductsEvent());

    on<UpdateListOfProductsEvent>(_onUpdateListOfProductsEvent);

    on<SaveProductEvent>(_onSaveProductsEvent);
  }

  /// ------------------------------------------------ UpdateListOfProductsEvent
  Future<void> _onUpdateListOfProductsEvent(
    UpdateListOfProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsInProgress());
    try {
      final products = <Product>[]; //await _productsManager.getProducts();
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(const ProductsFailure('Failure'));
    }
  }

  /// --------------------------------------------------------- SaveProductEvent
  Future<void> _onSaveProductsEvent(
    SaveProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    // await _productsManager.saveProduct(event.product);
    add(UpdateListOfProductsEvent());
  }
}
