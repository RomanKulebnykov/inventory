import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_catalog/products_catalog.dart';

part 'products_catalog_event.dart';
part 'products_catalog_state.dart';

class ProductsCatalogBloc
    extends Bloc<ProductsCatalogEvent, ProductsCatalogState> {
  /// --------------------------------------------------------------- Properties
  final ProductsRepository repository;

  ProductsCatalogBloc(this.repository) : super(ProductsCatalogInitial()) {
    on<ProductsCatalogReloadProductsEvent>((event, emit) async {
      emit(ProductsCatalogLoad());
      final products = await repository.list(ProductFilter());
      emit(ProductsCatalogShowProducts(productsList: products));
    });
    on<ProductsCatalogAddNewProductEvent>((event, emit) {});

    add(ProductsCatalogReloadProductsEvent());
  }
}
