import '../../models/orders/orders.dart';
import '../firestore.dart';

/// Abstract ///////////////////////////////////////////////////////////////////
abstract class MoneyOrdersRepository {}

/// Implementation /////////////////////////////////////////////////////////////
class MoneyOrdersRepositoryImpl extends MoneyOrdersRepository {
  MoneyOrdersRepositoryImpl({
    required this.getMoneyOrderCollectionPath,
  });

  final CollectionReference<Map<String, dynamic>>
      Function<T extends OrderMoney>() getMoneyOrderCollectionPath;
}
