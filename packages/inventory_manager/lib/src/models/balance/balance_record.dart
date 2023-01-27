import 'package:equatable/equatable.dart';

////////////////////////////////////////////////////////////////////////////////
/// BalanceRecord //////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class BalanceRecord extends Equatable {
  final double income;
  final double outcome;
  final double pending;
  final double reserve;
  double get amount => income - outcome;

  const BalanceRecord({
    this.income = 0,
    this.outcome = 0,
    this.reserve = 0,
    this.pending = 0,
  });

  operator +(BalanceRecord other) {
    return BalanceRecord(
      income: income + other.income,
      outcome: outcome + other.outcome,
      pending: pending + other.pending,
      reserve: reserve + other.reserve,
    );
  }

  operator -(BalanceRecord other) {
    return BalanceRecord(
      income: income - other.income,
      outcome: outcome - other.outcome,
      pending: pending - other.pending,
      reserve: reserve - other.reserve,
    );
  }

  @override
  List<Object?> get props => [income, outcome, pending, reserve];

  BalanceRecord copyWith({
    double? income,
    double? outcome,
    double? pending,
    double? reserve,
  }) {
    return BalanceRecord(
      income: income ?? this.income,
      outcome: outcome ?? this.outcome,
      pending: pending ?? this.pending,
      reserve: reserve ?? this.reserve,
    );
  }

  @override
  String toString() {
    return '(income: $income,outcome: $outcome,pending: $pending,reserve: $reserve)';
  }
}
