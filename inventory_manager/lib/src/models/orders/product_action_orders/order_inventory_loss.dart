import '../orders.dart';

class OrderInventoryLoss extends OrderProductBalance {
  final String? inventoryOrderLink;
  OrderInventoryLoss({
    super.id,
    super.isActive,
    super.items,
    super.status,
    super.dateTime,
    super.description,
    this.inventoryOrderLink,
  });
}
