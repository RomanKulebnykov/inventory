import '../orders.dart';

class OrderInventory extends OrderProductPrepare {
  final List<String> enterOrders;
  final List<String> lossOrders;

  OrderInventory({
    super.id,
    super.isActive,
    super.status,
    super.dateTime,
    super.description,
    super.items,
    List<String>? enterOrders,
    List<String>? lossOrders,
  })  : enterOrders = enterOrders ?? [],
        lossOrders = lossOrders ?? [];
}
