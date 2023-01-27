import '../../models/orders/orders.dart';
import '../firestore.dart';

/// Abstract ///////////////////////////////////////////////////////////////////
abstract class ProductOrdersRepository {
  Future<T> getProductOrder<T extends OrderProduct>({
    Transaction? transaction,
    required String orderId,
  });

  Future<List<T>> getProductOrders<T extends OrderProduct>({
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<bool> saveProductOrder<T extends OrderProduct>({
    Transaction? transaction,
    required T newOrder,
  });

  Future<bool> deleteProductOrder<T extends OrderProduct>({
    Transaction? transaction,
    required String deleteOrderId,
  });
}

/// Implementation /////////////////////////////////////////////////////////////
class ProductOrdersRepositoryImpl extends ProductOrdersRepository {
  ProductOrdersRepositoryImpl({
    required this.getProductOrderCollectionPath,
  });

  final CollectionReference<Map<String, dynamic>>
      Function<T extends OrderProduct>() getProductOrderCollectionPath;

  @override
  Future<T> getProductOrder<T extends OrderProduct>({
    Transaction? transaction,
    required String orderId,
  }) async {
    final DocumentSnapshot<T> snapshot;

    if (transaction == null) {
      snapshot = await firestoreOrder<T>().doc(orderId).get();
    } else {
      snapshot = await transaction.get(firestoreOrder<T>().doc(orderId));
    }
    return snapshot.data()!;
  }

  @override
  Future<List<T>> getProductOrders<T extends OrderProduct>({
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final snapshot = await firestoreOrder<T>().get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  @override
  Future<bool> deleteProductOrder<T extends OrderProduct>({
    Transaction? transaction,
    required String deleteOrderId,
  }) async {
    try {
      if (transaction == null) {
        await firestoreOrder<T>().doc(deleteOrderId).delete();
      } else {
        transaction.delete(firestoreOrder<T>().doc(deleteOrderId));
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> saveProductOrder<T extends OrderProduct>({
    Transaction? transaction,
    required T newOrder,
  }) async {
    try {
      if (transaction == null) {
        await firestoreOrder<T>().doc(newOrder.id).set(newOrder);
      } else {
        transaction.set(firestoreOrder<T>().doc(newOrder.id), newOrder);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Extensions /////////////////////////////////////////////////////////////////
extension CollectionsOrders on ProductOrdersRepositoryImpl {
  CollectionReference<T> firestoreOrder<T extends OrderProduct>() {
    switch (T) {
      case OrderInventoryEnter:
        return getProductOrderCollectionPath<T>().withConverter<T>(
          fromFirestore: (snapshot, options) {
            return ConverterEnterOrder.fromFirestore(snapshot.data()!) as T;
          },
          toFirestore: (order, options) {
            return ConverterEnterOrder.toFirestore(
                order as OrderInventoryEnter);
          },
        );
      case OrderInventoryLoss:
        return getProductOrderCollectionPath<T>().withConverter<T>(
          fromFirestore: (snapshot, options) {
            return ConverterLossOrder.fromFirestore(snapshot.data()!) as T;
          },
          toFirestore: (order, options) {
            return ConverterLossOrder.toFirestore(order as OrderInventoryLoss);
          },
        );
      default:
        throw Error();
    }
  }
}
