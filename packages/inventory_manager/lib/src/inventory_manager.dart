import 'models/balance/balance.dart';
import 'models/orders/orders.dart';

class InventoryManagerException implements Exception {}

/// InventoryManager
abstract class InventoryManager {
  /// ProductOrder /////////////////////////////////////////////////////////////
  Future<T?> getProductOrder<T extends OrderProduct>({
    required String orderId,
  });
  Future<List<T>?> getProductOrders<T extends OrderProduct>({
    DateTime? fromDate,
    DateTime? toDate,
  });
  Future<bool> saveProductOrder<T extends OrderProduct>({
    required T newOrder,
  });
  Future<bool> deleteProductOrder<T extends OrderProduct>({
    required String deleteOrderId,
  });
  Future<bool> updateProductOrder<T extends OrderProduct>({
    required T updatedOrder,
  });

  /// MoneyOrder ///////////////////////////////////////////////////////////////
  Future<List<T>?> getMoneyOrders<T extends OrderMoney>({
    DateTime? fromDate,
    DateTime? toDate,
  });
  Future<T?> getMoneyOrder<T extends OrderMoney>({
    required String orderId,
  });
  Future<bool> saveMoneyOrder<T extends OrderMoney>({
    required T newOrder,
  });
  Future<bool> deleteMoneyOrder<T extends OrderMoney>({
    required String deleteOrderId,
  });
  Future<bool> updateMoneyOrder<T extends OrderMoney>({
    required T updatedOrder,
  });

  /// Balance //////////////////////////////////////////////////////////////////
  Future<BalanceRecord?> getBalanceForProduct({
    required String productId,
  });
  Future<BalanceRecord?> getBalanceForMoneyAccount({
    required String accountId,
  });
}
