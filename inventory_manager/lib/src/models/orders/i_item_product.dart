import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class ItemProduct extends Equatable {
  final String id;
  int get count;
  final double price;

  /// -------------------------------------------------------------- Constructor
  ItemProduct({
    required this.id,
    required double price,
  }) : price = _correctPrice(price);

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [id, count, price];

  /// --------------------------------------------------------------- Validators
  // Must be 0 or greater
  static double _correctPrice(double price) => max(price, 0.0);
}
