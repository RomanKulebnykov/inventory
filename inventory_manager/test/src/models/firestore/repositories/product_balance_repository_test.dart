import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  final productId = const Uuid().v4();

  // 2021, 1, 1 -- 2023, 2, 2, 14,

  final datesList = [
    DateTime(2020, 2, 20, 12, 50), //1
    DateTime(2021, 3, 15, 12, 50), //2 -?
    DateTime(2022, 1, 15, 12, 50), //3 -
    DateTime(2023, 1, 2, 12, 50), //4 -?
    DateTime(2023, 1, 5, 12, 50), //5 -?
    DateTime(2023, 2, 2, 12, 50), //6 -
    DateTime(2023, 2, 2, 13, 50), //7 -
    DateTime(2023, 3, 5, 12, 50), //8
  ];

  const rec1 = BalanceRecord(
    income: 1,
    outcome: 1,
    pending: 1,
    reserve: 1,
  );

  /// --------------------------------------------------------------------------
  late FakeFirebaseFirestore firestore;
  final repository = ProductBalanceRepositoryImpl(
    getBalanceCollectionPath: () => firestore.collection('TESTproductsBalance'),
  );

  setUp(() {
    firestore = FakeFirebaseFirestore();
  });

  group('ProductBalanceRepository', () {
    test('Should correct get current stats', () async {
      for (final date in datesList) {
        await repository.updateBalance(
          dateTime: date,
          orderId: const Uuid().v4(),
          id: productId,
          record: rec1,
        );
      }
      final ball = await repository.getBalance(id: productId);
      const expectRes = BalanceRecord(
        income: 8,
        pending: 8,
        outcome: 8,
        reserve: 8,
      );
      expect(ball, expectRes);
    });
    test('Should correct get period balance ...end ', () async {
      for (final date in datesList) {
        await repository.updateBalance(
          dateTime: date,
          orderId: const Uuid().v4(),
          id: productId,
          record: rec1,
        );
      }
      print(firestore.dump());
      final ball1 = await repository.getBalance(
        id: productId,
        endPeriod: DateTime(2023, 2, 2, 12, 0),
      );
      const expectRes1 = BalanceRecord(
        income: 5,
        pending: 5,
        outcome: 5,
        reserve: 5,
      );
      expect(ball1, expectRes1);

      /// ---
      final ball2 = await repository.getBalance(
        id: productId,
        endPeriod: DateTime(2023, 2, 2, 13, 0),
      );
      const expectRes2 = BalanceRecord(
        income: 6,
        pending: 6,
        outcome: 6,
        reserve: 6,
      );
      expect(ball2, expectRes2);

      /// ---
      final ball3 = await repository.getBalance(
        id: productId,
        endPeriod: DateTime(2023, 2, 2, 14, 0),
      );
      const expectRes3 = BalanceRecord(
        income: 7,
        pending: 7,
        outcome: 7,
        reserve: 7,
      );
      expect(ball3, expectRes3);
    });

    test('Should correct get period balance start... ', () async {
      for (final date in datesList) {
        await repository.updateBalance(
          dateTime: date,
          orderId: const Uuid().v4(),
          id: productId,
          record: rec1,
        );
      }
      final ball = await repository.getBalance(
        id: productId,
        startPeriod: DateTime(2023, 1, 5, 11, 50),
      );
      const expectRes = BalanceRecord(
        income: 4,
        pending: 4,
        outcome: 4,
        reserve: 4,
      );
      expect(ball, expectRes);
    });

    test('Should correct get period balance start...end ', () async {
      for (final date in datesList) {
        await repository.updateBalance(
          dateTime: date,
          orderId: const Uuid().v4(),
          id: productId,
          record: rec1,
        );
      }
      final ball = await repository.getBalance(
        id: productId,
        startPeriod: DateTime(2021, 1, 1),
        endPeriod: DateTime(2023, 2, 2, 14),
      );
      const expectRes = BalanceRecord(
        income: 6,
        pending: 6,
        outcome: 6,
        reserve: 6,
      );
      expect(ball, expectRes);
    });
  });
}
