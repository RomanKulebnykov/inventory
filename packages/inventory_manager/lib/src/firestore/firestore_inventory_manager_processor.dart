part of 'firestore_inventory_manager.dart';

extension FirestoreInventoryManagerProccesor on FirestoreInventoryManager {
  /// ------------------------------------------ _processSaveInventoryEnterOrder
  Future<void> _processSaveInventoryEnterOrder(
    OrderInventoryEnter newOrder,
    Transaction transaction,
  ) async {
    // Upd products balance
    for (var item in newOrder.items) {
      productBalanceRepository.updateBalance(
        record: BalanceRecord(outcome: item.count.toDouble()),
        id: item.id,
        orderId: newOrder.id,
        dateTime: newOrder.dateTime,
        transaction: transaction,
      );
    }
  }

  /// ------------------------------------------- _processSaveInventoryLossOrder
  Future<void> _processSaveInventoryLossOrder(
    OrderInventoryLoss newOrder,
    Transaction transaction,
  ) async {
    // Upd products balance
    for (var item in newOrder.items) {
      productBalanceRepository.updateBalance(
        record: BalanceRecord(income: item.count.toDouble()),
        id: item.id,
        orderId: newOrder.id,
        dateTime: newOrder.dateTime,
        transaction: transaction,
      );
    }
  }

  /// -------------------------------------------------- _processSaveOrderIncome
  Future<void> _processSaveOrderIncome(
    OrderIncome newOrder,
    Transaction transaction,
  ) async {
    if (newOrder.pendingOrderLink != null) {
      // Get pending order if set
      final OrderPending pendingOrder =
          await productOrderRepository.getProductOrder<OrderPending>(
        orderId: newOrder.pendingOrderLink!,
      );

      // Upd pendingOrder
      final updPendingOrder = pendingOrder.copyWith(
        incomeOrdersLinks: _addIfNotContains(
          pendingOrder.incomeOrdersLinks,
          newOrder.id,
        ),
        items: updatePrepareItems(
          pendingOrder.items,
          dependsProductItems: newOrder.items,
        ),
      );

      // Save pendingOrder
      productOrderRepository.saveProductOrder<OrderPending>(
        newOrder: updPendingOrder,
        transaction: transaction,
      );
    }
    // Upd product balance
    for (var item in newOrder.items) {
      productBalanceRepository.updateBalance(
        record: BalanceRecord(income: item.count.toDouble()),
        id: item.id,
        orderId: newOrder.id,
        dateTime: newOrder.dateTime,
        transaction: transaction,
      );
    }
    // Upd money balance
    moneyBalanceRepository.updateBalance(
      record: BalanceRecord(pending: newOrder.getSum()),
      id: newOrder.counterpartyAccountId,
      orderId: newOrder.id,
      dateTime: newOrder.dateTime,
      transaction: transaction,
    );
  }

  /// ------------------------------------------------- _processSaveOutcomeOrder
  Future<void> _processSaveOutcomeOrder(
    OrderOutcome newOrder,
    Transaction transaction,
  ) async {
    // Upd product balance
    for (var item in newOrder.items) {
      productBalanceRepository.updateBalance(
        record: BalanceRecord(outcome: item.count.toDouble()),
        id: item.id,
        orderId: newOrder.id,
        dateTime: newOrder.dateTime,
        transaction: transaction,
      );
    }
    // Upd money balance
    moneyBalanceRepository.updateBalance(
      record: BalanceRecord(outcome: newOrder.getSum()),
      id: newOrder.customerAccountId,
      orderId: newOrder.id,
      dateTime: newOrder.dateTime,
      transaction: transaction,
    );
  }
}
