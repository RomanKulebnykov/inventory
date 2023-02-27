import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/models/order_inventory_presentation.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:resizable_table/resizable_table.dart';

import '../../../models/resizable_table_persistance_impl.dart';

/// ****************************************************************************
/// ======================================================================= BLOC
/// ****************************************************************************
class OrderInventoryEnterBloc
    extends Bloc<OrderInventoryEnterEvent, OrderInventoryEnterState> {
  static addEvent(BuildContext context, OrderInventoryEnterEvent event) {
    context.read<OrderInventoryEnterBloc>().add(event);
  }

  /// --------------------------------------------------------------- Properties
  final ProductsRepository productRepository;
  final BrandsRepository brandsRepository;
  final ResizableTablePersistance persistance = PersistanceMemory('inventory');

  /// -------------------------------------------------------------- Constructor
  OrderInventoryEnterBloc({
    required this.productRepository,
    required this.brandsRepository,
  }) : super(OrderInventoryEnterInitial()) {
    /// ----------------------------------------- OrderInventoryEnterReloadEvent
    on<OrderInventoryEnterReloadEvent>((event, emit) async {
      emit(OrderInventoryEnterLoading());
      final productPresentations = await _getOrderPresentations();
      emit(OrderInventoryEnterShowOrders(
        resizableTablePersistance: persistance,
        orders: productPresentations,
      ));
    });

    /// ------------------------------------ OrderInventoryEnterAddNewOrderEvent
    on<OrderInventoryEnterAddNewOrderEvent>((event, emit) {
      emit(const OrderInventoryEnterEditOrder());
    });

    /// -------------------------------------- OrderInventoryEnterEditOrderEvent
    on<OrderInventoryEnterEditOrderEvent>((event, emit) {
      emit(OrderInventoryEnterEditOrder(
          editOrderInventoryEnter: event.orderInventoryEnter));
    });

    add(OrderInventoryEnterReloadEvent());
  }

  Future<List<OrderInventoryEnterPresentation>> _getOrderPresentations() async {
    return [];
  }
}

/// ****************************************************************************
/// ====================================================================== EVENT
/// ****************************************************************************
abstract class OrderInventoryEnterEvent extends Equatable {
  const OrderInventoryEnterEvent();

  @override
  List<Object> get props => [];
}

/// ----------------------------------------- ProductsCatalogReloadProductsEvent
class OrderInventoryEnterReloadEvent extends OrderInventoryEnterEvent {}

/// ------------------------------------------ ProductsCatalogAddNewProductEvent
class OrderInventoryEnterAddNewOrderEvent extends OrderInventoryEnterEvent {}

/// -------------------------------------------- ProductsCatalogEditProductEvent
class OrderInventoryEnterEditOrderEvent extends OrderInventoryEnterEvent {
  final OrderInventoryEnter orderInventoryEnter;

  const OrderInventoryEnterEditOrderEvent(this.orderInventoryEnter);
  @override
  List<Object> get props => [super.props, orderInventoryEnter];
}

/// ****************************************************************************
/// ====================================================================== STATE
/// ****************************************************************************

/// -------------------------------------------------------- OrderInventoryState
abstract class OrderInventoryEnterState extends Equatable {
  const OrderInventoryEnterState();

  @override
  List<Object> get props => [];
}

/// ------------------------------------------------------ OrderInventoryInitial
class OrderInventoryEnterInitial extends OrderInventoryEnterState {}

/// ------------------------------------------------------ OrderInventoryLoading
class OrderInventoryEnterLoading extends OrderInventoryEnterState {}

/// --------------------------------------------------- OrderInventoryShowOrders
class OrderInventoryEnterShowOrders extends OrderInventoryEnterState {
  final ResizableTablePersistance resizableTablePersistance;
  final List<OrderInventoryEnterPresentation> orders;

  const OrderInventoryEnterShowOrders({
    required this.resizableTablePersistance,
    required this.orders,
  });
}

/// ---------------------------------------------------- OrderInventoryEditOrder
class OrderInventoryEnterEditOrder extends OrderInventoryEnterState {
  final OrderInventoryEnter? editOrderInventoryEnter;

  const OrderInventoryEnterEditOrder({this.editOrderInventoryEnter});
}
