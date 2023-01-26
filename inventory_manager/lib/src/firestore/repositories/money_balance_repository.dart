import '../../models/balance/balance.dart';
import '../firestore.dart';

/// Abstract ///////////////////////////////////////////////////////////////////
abstract class MoneyBalanceRepository {
  Future<BalanceRecord> getBalance({
    required String id,
    DateTime? startPeriod,
    DateTime? endPeriod,

    // required Transaction transaction,
  });

  Future<void> updateBalance({
    required BalanceRecord record,
    required String id,
    required String orderId,
    required DateTime dateTime,
    // required Transaction transaction,
  });
}

///#############################################################################
/// Implementation /////////////////////////////////////////////////////////////
///#############################################################################

class MoneyBalanceRepositoryImpl extends FirestoreBalanceRepository
    implements MoneyBalanceRepository {
  MoneyBalanceRepositoryImpl({
    required super.getBalanceCollectionPath,
  });
}
