import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/balance/balance.dart';
import '../converters/converter_balance_record.dart';

typedef CollRef = CollectionReference<Map<String, dynamic>>;

abstract class FirestoreBalanceRepository {
  /// -------------------------------------------------------------- Constructor
  FirestoreBalanceRepository({
    required this.getBalanceCollectionPath,
  });

  /// ------------------------------------------------------------ Path callback
  final CollRef Function() getBalanceCollectionPath;

  final yearKey = 'years';
  final monthKey = 'month';
  final recordKey = 'record';

  /// -------------------------------------------------------------updateBalance

  Future<void> updateBalance({
    required BalanceRecord record,
    required String id,
    required String orderId,
    required DateTime dateTime,
    Transaction? transaction,
  }) async {
    final year = dateTime.year;
    final month = dateTime.month;

    final updateDoc = {
      "income": FieldValue.increment(record.income),
      "outcome": FieldValue.increment(record.outcome),
      "pending": FieldValue.increment(record.pending),
      "reserve": FieldValue.increment(record.reserve),
    };

    final currBall = getBalanceCollectionPath().doc(id);
    final yearBall =
        getBalanceCollectionPath().doc(id).collection(yearKey).doc('$year');
    final monthBall = getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .doc('$year')
        .collection(monthKey)
        .doc('$month');

    final ballRec = getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .doc('$year')
        .collection(monthKey)
        .doc('$month')
        .collection(recordKey)
        .doc(orderId);

    if (transaction != null) {
      transaction.set(currBall, updateDoc, SetOptions(merge: true));
      transaction.set(yearBall, updateDoc, SetOptions(merge: true));
      transaction.set(monthBall, updateDoc, SetOptions(merge: true));
      transaction.set(ballRec, {"dateTime": dateTime, ...updateDoc});
    } else {
      currBall.set(updateDoc, SetOptions(merge: true));
      yearBall.set(updateDoc, SetOptions(merge: true));
      monthBall.set(updateDoc, SetOptions(merge: true));
      ballRec.set({"dateTime": dateTime, ...updateDoc});
    }
  }

  /// --------------------------------------------------------------- getBalance
  Future<BalanceRecord> getBalance({
    DateTime? startPeriod,
    DateTime? endPeriod,
    required String id,
  }) async {
    final List<Query<Map<String, dynamic>>> queriesList;
    // ------------------------------------------------------------- START...END
    if (startPeriod != null && endPeriod != null) {
      queriesList = _getPeriodBalance(
        id: id,
        startPeriod: startPeriod,
        endPeriod: endPeriod,
      );
      // ---------------------------------------------------------------- ...END
    } else if (startPeriod == null && endPeriod != null) {
      queriesList = _getToEndBalance(
        id: id,
        endPeriod: endPeriod,
      );
      // -------------------------------------------------------------- START...
    } else if (startPeriod != null && endPeriod == null) {
      queriesList = _getFromStartBalance(
        id: id,
        startPeriod: startPeriod,
      );
    } else {
      // --------------------------------------------------------------- CURRENT
      return await getCurrentBalance(id: id);
    }
    final records = await _fetchRecords(
      queriesList,
    );
    return _calculate(records);
  }

  ///  ------------------------------------------------------- getCurrentBalance
  Future<BalanceRecord> getCurrentBalance({
    Transaction? transaction,
    required String id,
  }) async {
    final docRef = getBalanceCollectionPath().doc(id);
    final DocumentSnapshot<Map<String, dynamic>> snap;
    if (transaction == null) {
      snap = await docRef.get();
    } else {
      snap = await transaction.get(docRef);
    }
    return ConverterBalanceRecord.fromFirestore(snap.data()!);
  }

  ///  -------------------------------------------------------- _getToEndBalance
  List<Query<Map<String, dynamic>>> _getToEndBalance({
    required String id,
    required DateTime endPeriod,
  }) {
    final endYear = endPeriod.year;
    final endMonth = endPeriod.month;

    final yearQuery = getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .where(FieldPath.documentId, isLessThan: '$endYear');

    return [
      yearQuery,
      _headMonthQuery(id, endYear, endMonth),
      _headsRecordsQuery(id, endYear, endMonth, endPeriod),
    ];
  }

  ///  ---------------------------------------------------- _getFromStartBalance
  List<Query<Map<String, dynamic>>> _getFromStartBalance({
    required String id,
    required DateTime startPeriod,
  }) {
    final startYear = startPeriod.year;
    final startMonth = startPeriod.month;

    final yearQuery = getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .where(FieldPath.documentId, isGreaterThan: '$startYear');

    return [
      yearQuery,
      _tailMonthQuery(id, startYear, startMonth),
      _tailRecordsQuery(id, startYear, startMonth, startPeriod),
    ];
  }

  ///  ------------------------------------------------------- _getPeriodBalance
  List<Query<Map<String, dynamic>>> _getPeriodBalance({
    required String id,
    required DateTime startPeriod,
    required DateTime endPeriod,
  }) {
    final startYear = startPeriod.year;
    final startMonth = startPeriod.month;
    final endYear = endPeriod.year;
    final endMonth = endPeriod.month;

    final yearQuery = getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .where(FieldPath.documentId, isGreaterThan: '$startYear')
        .where(FieldPath.documentId, isLessThan: '$endYear');

    return [
      yearQuery,
      _tailMonthQuery(id, startYear, startMonth),
      _tailRecordsQuery(id, startYear, startMonth, startPeriod),
      _headMonthQuery(id, endYear, endMonth),
      _headsRecordsQuery(id, endYear, endMonth, endPeriod),
    ];
  }

  /// ================================================================== Queries
  /// ------------------------------------------------------- _headsRecordsQuery
  Query<Map<String, dynamic>> _headsRecordsQuery(
    String id,
    int endYear,
    int endMonth,
    DateTime endPeriod,
  ) {
    return getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .doc('$endYear')
        .collection(monthKey)
        .doc('$endMonth')
        .collection(recordKey)
        .where('dateTime', isLessThan: endPeriod);
  }

  /// ---------------------------------------------------------- _headMonthQuery
  Query<Map<String, dynamic>> _headMonthQuery(
    String id,
    int endYear,
    int endMonth,
  ) {
    return getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .doc('$endYear')
        .collection(monthKey)
        .where(FieldPath.documentId, isLessThan: '$endMonth');
  }

  /// ---------------------------------------------------------- _tailMonthQuery
  Query<Map<String, dynamic>> _tailMonthQuery(
    String id,
    int startYear,
    int startMonth,
  ) {
    return getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .doc('$startYear')
        .collection(monthKey)
        .where(FieldPath.documentId, isGreaterThan: '$startMonth');
  }

  /// -------------------------------------------------------- _tailRecordsQuery
  Query<Map<String, dynamic>> _tailRecordsQuery(
    String id,
    int startYear,
    int startMonth,
    DateTime startPeriod,
  ) {
    return getBalanceCollectionPath()
        .doc(id)
        .collection(yearKey)
        .doc('$startYear')
        .collection(monthKey)
        .doc('$startMonth')
        .collection(recordKey)
        .where('dateTime', isGreaterThan: startPeriod);
  }

  /// ================================================================== Helpers
  /// -------------------------------------------------------- _recordsFromQuery
  Future<List<BalanceRecord>> _recordsFromQuery(
    Query<Map<String, dynamic>> query,
  ) async {
    final querySnap = await query.get();
    final List<BalanceRecord> result = [];
    for (var element in querySnap.docs) {
      result.add(ConverterBalanceRecord.fromFirestore(element.data()));
    }
    return result;
  }

  /// ------------------------------------------------------------ _fetchRecords
  Future<List<BalanceRecord>> _fetchRecords(
    List<Query<Map<String, dynamic>>> queries,
  ) async {
    List<BalanceRecord> records = [];
    for (var query in queries) {
      var list = await _recordsFromQuery(query);

      print(list);
      records.addAll(list);
    }
    return records;
  }

  /// --------------------------------------------------------------- _calculate
  BalanceRecord _calculate(List<BalanceRecord> records) {
    return records.fold(
      const BalanceRecord(),
      (previousValue, element) => previousValue + element,
    );
  }
}
