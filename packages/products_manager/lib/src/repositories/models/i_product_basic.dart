import 'package:equatable/equatable.dart';

class ProductBasic extends Equatable {
  final String id;
  final String title;
  final String code;

  // final double defaultEntryPrice;
  // final double defaultSellingPrice;

  /// -------------------------------------------------------------- Constructor
  const ProductBasic({
    required this.id,
    required this.title,
    required this.code,
    // required this.defaultEntryPrice,
    // required this.defaultSellingPrice,
  });

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [
        id,
        title,
        code,
        // defaultEntryPrice,
      ];
}
