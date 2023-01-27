part of 'firestore_inventory_manager.dart';

extension FirestoreInventoryManagerCreator on FirestoreInventoryManager {
  /// ------------------------------------------------------createInventoryEnter
  OrderInventoryEnter createInventoryEnter(OrderInventory inventoryOrder) {
    final List<ItemBalance> orderItems = [];
    for (var invItem in inventoryOrder.items) {
      if (invItem.expect < invItem.actually) {
        orderItems.add(
          ItemBalance(
            id: invItem.id,
            price: invItem.price,
            count: invItem.actually - invItem.expect,
          ),
        );
      }
    }
    return OrderInventoryEnter(
      items: orderItems,
      inventoryOrderLink: inventoryOrder.id,
    );
  }

  /// -------------------------------------------------------createInventoryLoss
  OrderInventoryLoss createInventoryLoss(OrderInventory inventoryOrder) {
    final List<ItemBalance> orderItems = [];
    for (var invItem in inventoryOrder.items) {
      if (invItem.expect > invItem.actually) {
        orderItems.add(
          ItemBalance(
            id: invItem.id,
            price: invItem.price,
            count: invItem.expect - invItem.actually,
          ),
        );
      }
    }
    return OrderInventoryLoss(
      items: orderItems,
      inventoryOrderLink: inventoryOrder.id,
    );
  }

  /// --------------------------------------------------------------createIncome
  OrderIncome createIncome(OrderPending pendingOrder) {
    final List<ItemBalance> orderItems = [];
    for (var invItem in pendingOrder.items) {
      if (invItem.expect > invItem.actually) {
        orderItems.add(
          ItemBalance(
            id: invItem.id,
            price: invItem.price,
            count: invItem.expect - invItem.actually,
          ),
        );
      }
    }
    return OrderIncome(
      counterpartyAccountId: pendingOrder.counterpartyAccountId,
      organizationAccountId: pendingOrder.organizationAccountId,
      pendingOrderLink: pendingOrder.id,
      items: orderItems,
    );
  }

  /// -------------------------------------------------------------createOutcome
  OrderOutcome createOutcome(OrderReserve reserveOrder) {
    final List<ItemBalance> orderItems = [];
    for (var invItem in reserveOrder.items) {
      if (invItem.expect > invItem.actually) {
        orderItems.add(
          ItemBalance(
            id: invItem.id,
            price: invItem.price,
            count: invItem.expect - invItem.actually,
          ),
        );
      }
    }
    return OrderOutcome(
      organizationAccountId: reserveOrder.organizationAccountId,
      customerAccountId: reserveOrder.organizationAccountId,
      reserveOrderLink: reserveOrder.id,
      items: orderItems,
    );
  }

  /// --------------------------------------------------------createReturnIncome
  OrderReturnIncome createReturnIncome() {
    return OrderReturnIncome();
  }

  /// -------------------------------------------------------createReturnOutcome
  OrderReturnOutcome createReturnOutcome() {
    return OrderReturnOutcome();
  }
}
