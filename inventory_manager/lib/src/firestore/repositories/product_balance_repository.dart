import '../../models/balance/balance.dart';
import '../firestore.dart';

/// Abstract ///////////////////////////////////////////////////////////////////
abstract class ProductBalanceRepository {
  Future<BalanceRecord> getBalance({
    required String id,
    DateTime? startPeriod,
    DateTime? endPeriod,
  });

  Future<BalanceRecord> getCurrentBalance({
    required String id,
    // Transaction? transaction,
  });

  Future<void> updateBalance({
    required String id,
    required BalanceRecord record,
    required String orderId,
    required DateTime dateTime,
    // required Transaction transaction,
  });
}

///#############################################################################
/// Implementation /////////////////////////////////////////////////////////////
///#############################################################################
class ProductBalanceRepositoryImpl extends FirestoreBalanceRepository
    implements ProductBalanceRepository {
  /// -------------------------------------------------------------- Constructor
  ProductBalanceRepositoryImpl({
    required super.getBalanceCollectionPath,
  });
}
