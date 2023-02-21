import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_inventory_event.dart';
part 'order_inventory_state.dart';

class OrderInventoryBloc
    extends Bloc<OrderInventoryEvent, OrderInventoryState> {
  OrderInventoryBloc() : super(OrderInventoryInitial()) {
    on<OrderInventoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
