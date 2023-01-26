import 'dart:math';
import '../orders.dart';

class ItemPrepare extends ItemProduct {
  final int expect;
  final int actually;

  @override
  int get count => actually;

  /// -------------------------------------------------------------- Constructor
  ItemPrepare({
    required super.id,
    required super.price,
    required int expect,
    required int actually,
  })  : expect = _correctExpect(expect),
        actually = _correctActually(actually, expect);

  /// ------------------------------------------------------------------- isDone
  bool get isDone => expect == actually;

  /// ------------------------------------------------------------ updateDepends
  ItemPrepare updateDepends({required ItemBalance itemAction}) {
    return ItemPrepare(
      id: id,
      price: price,
      expect: expect,
      actually: min(expect, actually + itemAction.count),
    );
  }

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [...super.props, expect, actually];

  /// --------------------------------------------------------------- Validators
  // Must be 1 or greater
  static int _correctExpect(int expect) => max(expect, 1);

  // Must be 0 or greater and less or equal than expect
  static int _correctActually(int actually, int expect) {
    final corExp = _correctExpect(expect);
    final corAct = max(actually, 0);
    return corAct < corExp ? corAct : corExp;
  }
}
