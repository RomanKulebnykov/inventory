import '../orders.dart';

abstract class OrderProductPrepare extends OrderProduct<ItemPrepare> {
  /// -------------------------------------------------------------- Constructor
  OrderProductPrepare({
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
