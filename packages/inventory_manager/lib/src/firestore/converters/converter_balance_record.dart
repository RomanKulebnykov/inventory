import '../../models/balance/balance.dart';

class ConverterBalanceRecord {
  ConverterBalanceRecord._internal();

  static Map<String, dynamic> toFirestore(BalanceRecord record) {
    return {
      'income': record.income,
      'outcome': record.outcome,
      'pending': record.pending,
      'reserve': record.reserve,
    };
  }

  static BalanceRecord fromFirestore(Map<String, dynamic> snapshot) {
    return BalanceRecord(
      income: double.tryParse(snapshot['income'].toString())!,
      outcome: double.tryParse(snapshot['outcome'].toString())!,
      pending: double.tryParse(snapshot['pending'].toString())!,
      reserve: double.tryParse(snapshot['reserve'].toString())!,
    );
  }
}
