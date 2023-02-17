import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_catalog/products_catalog.dart';

part 'products_catalog_event.dart';
part 'products_catalog_state.dart';

class ProductsCatalogBloc
    extends Bloc<ProductsCatalogEvent, ProductsCatalogState> {
  final ProductsRepository repository;

  ProductsCatalogBloc(this.repository) : super(ProductsCatalogInitial()) {
    on<ProductsCatalogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
