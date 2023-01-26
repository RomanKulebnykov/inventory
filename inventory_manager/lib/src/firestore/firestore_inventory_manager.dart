import 'dart:math';

import 'package:collection/collection.dart';

import '../inventory_manager.dart';
import '../models/balance/balance.dart';
import '../models/orders/orders.dart';
import 'firestore.dart';

part 'firestore_inventory_manager_helper.dart';
part 'firestore_inventory_manager_creator.dart';
part 'firestore_inventory_manager_processor.dart';

class FirestoreInventoryManager extends InventoryManager {
  /// Constructor
  FirestoreInventoryManager({
    required this.firestore,
    required this.productOrderRepository,
    required this.productBalanceRepository,
    required this.moneyOrdersRepository,
    required this.moneyBalanceRepository,
  });

  /// Repositories
  final ProductOrdersRepositoryImpl productOrderRepository;
  final ProductBalanceRepositoryImpl productBalanceRepository;
  final MoneyOrdersRepositoryImpl moneyOrdersRepository;
  final MoneyBalanceRepositoryImpl moneyBalanceRepository;

  /// Properties
  final FirebaseFirestore firestore;

  ///###########################################################################
  /// ProductOrder API /////////////////////////////////////////////////////////
  ///###########################################################################

  /// -----------------------------------------------------------getProductOrder
  @override
  Future<T?> getProductOrder<T extends OrderProduct>({
    required String orderId,
  }) {
    return productOrderRepository.getProductOrder<T>(
      orderId: orderId,
    );
  }

  /// ----------------------------------------------------------getProductOrders
  @override
  Future<List<T>?> getProductOrders<T extends OrderProduct>({
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return productOrderRepository.getProductOrders(
      fromDate: fromDate,
      toDate: toDate,
    );
  }

  /// ----------------------------------------------------------saveProductOrder
  @override
  Future<bool> saveProductOrder<T extends OrderProduct>({
    required T newOrder,
  }) async {
    try {
      final result = await firestore.runTransaction<bool>(
        (transaction) async {
          switch (T) {
            case OrderInventoryEnter: //  -------------------InventoryEnterOrder
              _processSaveInventoryEnterOrder(
                newOrder as OrderInventoryEnter,
                transaction,
              );

              break;
            case OrderInventoryLoss: //  ---------------------InventoryLossOrder
              _processSaveInventoryLossOrder(
                newOrder as OrderInventoryLoss,
                transaction,
              );
              break;
            case OrderIncome: //  -----------------------------------IncomeOrder
              _processSaveOrderIncome(
                newOrder as OrderIncome,
                transaction,
              );
              break;
            case OrderOutcome: //  ---------------------------------OutcomeOrder
              _processSaveOutcomeOrder(
                newOrder as OrderOutcome,
                transaction,
              );
              break;
            default:
              throw Error();
          }
          // Save order
          productOrderRepository.saveProductOrder<T>(
            newOrder: newOrder,
            transaction: transaction,
          );
          return true;
        },
      );
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// --------------------------------------------------------deleteProductOrder
  @override
  Future<bool> deleteProductOrder<T extends OrderProduct>({
    required String deleteOrderId,
  }) async {
    try {
      final result = await firestore.runTransaction<bool>(
        (transaction) async {
          return true;
        },
      );
      return result;
    } catch (e) {
      return false;
    }
  }

  /// --------------------------------------------------------updateProductOrder
  @override
  Future<bool> updateProductOrder<T extends OrderProduct>({
    required T updatedOrder,
  }) async {
    try {
      final result = await firestore.runTransaction<bool>(
        (transaction) async {
          return true;
        },
      );
      return result;
    } catch (e) {
      return false;
    }
  }

  ///###########################################################################
  /// MoneyOrder API ///////////////////////////////////////////////////////////
  ///###########################################################################

  /// -------------------------------------------------------------getMoneyOrder
  @override
  Future<T?> getMoneyOrder<T extends OrderMoney>({
    required String orderId,
  }) {
    // TODO: implement getMoneyOrder
    throw UnimplementedError();
  }

  /// ------------------------------------------------------------getMoneyOrders
  @override
  Future<List<T>?> getMoneyOrders<T extends OrderMoney>({
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    // TODO: implement getMoneyOrders
    throw UnimplementedError();
  }

  /// ------------------------------------------------------------saveMoneyOrder
  @override
  Future<bool> saveMoneyOrder<T extends OrderMoney>({
    required T newOrder,
  }) {
    // TODO: implement saveMoneyOrder
    throw UnimplementedError();
  }

  /// ----------------------------------------------------------deleteMoneyOrder
  @override
  Future<bool> deleteMoneyOrder<T extends OrderMoney>({
    required String deleteOrderId,
  }) {
    // TODO: implement deleteMoneyOrder
    throw UnimplementedError();
  }

  /// ----------------------------------------------------------updateMoneyOrder
  @override
  Future<bool> updateMoneyOrder<T extends OrderMoney>({
    required T updatedOrder,
  }) {
    // TODO: implement updateMoneyOrder
    throw UnimplementedError();
  }

  ///###########################################################################
  /// Balance API //////////////////////////////////////////////////////////////
  ///###########################################################################

  /// -------------------------------------------------getBalanceForMoneyAccount
  @override
  Future<BalanceRecord?> getBalanceForMoneyAccount({
    required String accountId,
  }) {
    // TODO: implement getBalanceForMoneyAccount
    throw UnimplementedError();
  }

  /// ------------------------------------------------------getBalanceForProduct
  @override
  Future<BalanceRecord?> getBalanceForProduct({
    required String productId,
  }) {
    // TODO: implement getBalanceForProduct
    throw UnimplementedError();
  }
}
