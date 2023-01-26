import 'package:inventory_manager/inventory_manager.dart';
import 'package:inventory_manager/src/firestore/converters/converter_balance_record.dart';
import 'package:test/test.dart';

void main() {
  group('ConverterBalanceRecord', () {
    const rec = BalanceRecord(income: 5, outcome: -2, pending: 4, reserve: 2);
    const map = {'income': 5, 'outcome': -2, 'pending': 4, 'reserve': 2};
    late Map<String, dynamic> convertValue;
    late BalanceRecord resultValue;
    test('Should correct convert to firestore', () {
      convertValue = ConverterBalanceRecord.toFirestore(rec);
      expect(convertValue, map);
    });
    test('Should correct convert from firestore', () {
      convertValue = ConverterBalanceRecord.toFirestore(rec);
      resultValue = ConverterBalanceRecord.fromFirestore(convertValue);
      expect(resultValue, rec);
    });
  });
}
