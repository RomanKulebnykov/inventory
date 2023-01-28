import 'package:equatable/equatable.dart';

class IProduct extends Equatable {
  final String id;
  final String title;
  final String code;
  final List<String> articles;
  final double entryPrice;
  final double sellingPrice;
  final String? description;
  final String? imagePath;

  /// -------------------------------------------------------------- Constructor
  const IProduct({
    required this.id,
    required this.title,
    required this.code,
    required this.entryPrice,
    required this.sellingPrice,
    required this.articles,
    this.description,
    this.imagePath,
  });

  /// -------------------------------------------------------------------- props
  @override
  List<Object?> get props => [
        id,
        title,
        code,
        entryPrice,
        sellingPrice,
        articles,
        description,
        imagePath,
      ];
}
