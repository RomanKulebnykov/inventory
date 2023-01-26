import 'package:equatable/equatable.dart';

class ProductBasic extends Equatable {
  final String id;
  final String title;
  final String code;

  final double defaultPrice;

  /// -------------------------------------------------------------- Constructor
  const ProductBasic({
    required this.id,
    required this.title,
    required this.code,
    required this.defaultPrice,
  });

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [id, title, code, defaultPrice];
}
