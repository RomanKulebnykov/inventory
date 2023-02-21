part of 'order_inventory_bloc.dart';

abstract class OrderInventoryState extends Equatable {
  const OrderInventoryState();

  @override
  List<Object> get props => [];
}

class OrderInventoryInitial extends OrderInventoryState {}
