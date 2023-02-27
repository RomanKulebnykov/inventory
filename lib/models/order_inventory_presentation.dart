import 'package:inventory_manager/inventory_manager.dart';

class OrderInventoryEnterPresentation {
  final String id;
  final String description;
  final bool isActive;
  final DateTime dateTime;
  final OrderStatus status;
  final String? inventoryOrderLink;
  final List<ItemBalance> items;

  OrderInventoryEnterPresentation.fromOrder(OrderInventoryEnter order)
      : id = order.id,
        description = order.description,
        isActive = order.isActive,
        dateTime = order.dateTime,
        status = order.status,
        inventoryOrderLink = order.inventoryOrderLink,
        items = order.items;

  OrderInventoryEnter get toOrder {
    return OrderInventoryEnter(
      id: id,
      description: description,
      isActive: isActive,
      dateTime: dateTime,
      status: status,
      inventoryOrderLink: inventoryOrderLink,
      items: items,
    );
  }
}
