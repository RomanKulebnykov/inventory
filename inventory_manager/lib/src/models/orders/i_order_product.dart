import 'orders.dart';

abstract class OrderProduct<T extends ItemProduct> extends OrderBasic {
  /// -------------------------------------------------------------- Constructor
  OrderProduct({
    super.id,
    super.isActive,
    super.status,
    super.dateTime,
    super.description,
    List<T>? items,
  }) : items = items ?? [];

  /// -------------------------------------------------------------------- items
  final List<T> items;

  /// --------------------------------------------------------------- countItems
  int get countItems => items.length;

  /// -------------------------------------------------------------- getOrderSum
  double getSum() {
    return items.fold(
      0.0,
      (previousValue, element) => previousValue + element.count * element.price,
    );
  }

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [...super.props, items];

  /// ----------------------------------------------------------------- toString
  @override
  String toString() => '${super.toString()} \n items: $items}';
}
