import '../orders.dart';

class OrderInventoryEnter extends OrderProductBalance {
  final String? inventoryOrderLink;
  OrderInventoryEnter({
    super.id,
    super.isActive,
    super.items,
    super.status,
    super.dateTime,
    super.description,
    this.inventoryOrderLink,
  });
}
