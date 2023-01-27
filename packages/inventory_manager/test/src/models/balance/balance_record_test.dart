import 'package:test/test.dart';
import 'package:inventory_manager/inventory_manager.dart';

void main() {
  const rec1 = BalanceRecord(
    income: 5,
    outcome: 4,
    reserve: 2,
    pending: 7,
  );

  const rec2 = BalanceRecord(
    income: 4,
    outcome: 2,
    reserve: 7,
    pending: 3,
  );

  const expectedRec1and2Sum = BalanceRecord(
    income: 9,
    outcome: 6,
    reserve: 9,
    pending: 10,
  );
  const expectedRec1and2Sub = BalanceRecord(
    income: 1,
    outcome: 2,
    reserve: -5,
    pending: 4,
  );

  /// BalanceRecord Tests //////////////////////////////////////////////////////
  group('Balance Record', () {
    test('Balance should correct adding', () {
      final balRes3 = rec1 + rec2;
      expect(balRes3, expectedRec1and2Sum);
    });
    test('Balance should correct subtracting', () {
      final balRes3 = rec1 - rec2;
      expect(balRes3, expectedRec1and2Sub);
    });
  });
}
