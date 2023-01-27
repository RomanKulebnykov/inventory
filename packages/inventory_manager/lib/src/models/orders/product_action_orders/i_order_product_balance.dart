import '../orders.dart';

abstract class OrderProductBalance extends OrderProduct<ItemBalance> {
  /// -------------------------------------------------------------- Constructor
  OrderProductBalance({
    super.id,
    super.isActive,
    super.status,
    super.dateTime,
    super.description,
    super.items,
  });

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [...super.props];
}
