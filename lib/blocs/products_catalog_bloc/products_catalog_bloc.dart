import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/models/product_presentation.dart';
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
  final ProductsRepository productRepository;
  final BrandsRepository brandsRepository;
  final ResizableTablePersistance persistance = PersistanceMemory('nnnn');

  /// -------------------------------------------------------------- Constructor
  ProductsCatalogBloc({
    required this.productRepository,
    required this.brandsRepository,
  }) : super(ProductsCatalogInitial()) {
    /// ------------------------------------- ProductsCatalogReloadProductsEvent
    on<ProductsCatalogReloadProductsEvent>((event, emit) async {
      emit(ProductsCatalogLoad());
      final productPresentations = await _getProductPresentations();
      emit(ProductsCatalogShowProducts(
        productsList: productPresentations,
        resizableTablePersistance: persistance,
      ));
    });

    /// -------------------------------------- ProductsCatalogAddNewProductEvent
    on<ProductsCatalogAddNewProductEvent>((event, emit) {
      emit(const ProductsCatalogEditProduct());
    });

    /// ---------------------------------------- ProductsCatalogEditProductEvent
    on<ProductsCatalogEditProductEvent>((event, emit) {
      emit(ProductsCatalogEditProduct(editedProduct: event.product));
    });

    add(ProductsCatalogReloadProductsEvent());
  }

  /// -------------------------------------------------- _getProductPresentations
  Future<List<ProductPresentation>> _getProductPresentations() async {
    final productEntities = await productRepository.list(ProductFilter());
    List<ProductPresentation> result = [];
    for (final productEntity in productEntities) {
      Brand? brand;
      if (productEntity.brandId != null) {
        brand = await brandsRepository.getById(productEntity.brandId!);
      }
      result.add(ProductPresentation.fromProduct(
        product: productEntity,
        brand: brand,
      ));
    }
    return result;
  }
}
