import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/models/product_presentation.dart';
import 'package:inventory/models/resizable_table_persistance_impl.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:resizable_table/resizable_table.dart';

/// ****************************************************************************
/// ======================================================================= BLOC
/// ****************************************************************************
class ProductsCatalogBloc
    extends Bloc<ProductsCatalogEvent, ProductsCatalogState> {
  /// -------------------------------------------------------- Bloc acces helper
  static addEvent(BuildContext context, ProductsCatalogEvent event) {
    context.read<ProductsCatalogBloc>().add(event);
  }

  /// --------------------------------------------------------------- Properties
  final ProductsRepository productRepository;
  final BrandsRepository brandsRepository;
  final ResizableTablePersistance persistance = PersistanceMemory('products');

  /// -------------------------------------------------------------- Constructor
  ProductsCatalogBloc({
    required this.productRepository,
    required this.brandsRepository,
  }) : super(ProductsCatalogInitial()) {
    /// ------------------------------------- ProductsCatalogReloadProductsEvent
    on<ProductsCatalogReloadProductsEvent>((event, emit) async {
      emit(ProductsCatalogLoading());
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

  /// ---------------------------------------------------------- PRIVATE METHODS
  /// ------------------------------------------------- _getProductPresentations
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

/// ****************************************************************************
/// ===================================================================== EVENTS
/// ****************************************************************************

/// ------------------------------------------------------- ProductsCatalogEvent
abstract class ProductsCatalogEvent extends Equatable {
  const ProductsCatalogEvent();

  @override
  List<Object?> get props => [];
}

/// ----------------------------------------- ProductsCatalogReloadProductsEvent
class ProductsCatalogReloadProductsEvent extends ProductsCatalogEvent {}

/// ------------------------------------------ ProductsCatalogAddNewProductEvent
class ProductsCatalogAddNewProductEvent extends ProductsCatalogEvent {}

/// -------------------------------------------- ProductsCatalogEditProductEvent
class ProductsCatalogEditProductEvent extends ProductsCatalogEvent {
  const ProductsCatalogEditProductEvent(this.product);
  final Product product;

  @override
  List<Object?> get props => [super.props, product];
}

/// ****************************************************************************
/// ====================================================================== STATE
/// ****************************************************************************

/// ------------------------------------------------------- ProductsCatalogState
abstract class ProductsCatalogState extends Equatable {
  const ProductsCatalogState();
  @override
  List<Object> get props => [];
}

/// ----------------------------------------------------- ProductsCatalogInitial
class ProductsCatalogInitial extends ProductsCatalogState {}

/// ----------------------------------------------------- ProductsCatalogLoading
class ProductsCatalogLoading extends ProductsCatalogState {}

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
