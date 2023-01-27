import 'dart:math';

import '../orders.dart';

class ItemBalance extends ItemProduct {
  @override
  final int count;

  /// -------------------------------------------------------------- Constructor
  ItemBalance({
    required super.id,
    required super.price,
    required int count,
  }) : count = _correctCount(count);

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [...super.props];

  /// --------------------------------------------------------------- Validators
  // Must be 1 or greater
  static int _correctCount(int count) => max(count, 1);
}
