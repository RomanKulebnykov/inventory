import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'products_catalog_event.dart';
part 'products_catalog_state.dart';

class ProductsCatalogBloc
    extends Bloc<ProductsCatalogEvent, ProductsCatalogState> {
  ProductsCatalogBloc() : super(ProductsCatalogInitial()) {
    on<ProductsCatalogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
