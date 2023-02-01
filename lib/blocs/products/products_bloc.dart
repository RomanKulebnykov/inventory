import 'package:bloc/bloc.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:products_manager/products_manager.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsManager _productsManager;
  ProductsBloc(this._productsManager) : super(ProductsInitial()) {
    if (state is ProductsInitial) add(UpdateListOfProductsEvent());

    /// ---------------------------------------------- UpdateListOfProductsEvent
    on<UpdateListOfProductsEvent>((event, emit) async {
      emit(ProductsInProgress());
      try {
        final products = await _productsManager.getProducts();
        emit(ProductsSuccess(products));
      } catch (e) {
        emit(const ProductsFailure('Failure'));
      }
    });

    /// ------------------------------------------------------- SaveProductEvent
    on<SaveProductEvent>((event, emit) async {
      await _productsManager.saveProduct(event.product);
      add(UpdateListOfProductsEvent());
    });
  }
}
