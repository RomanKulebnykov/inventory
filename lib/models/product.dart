import 'package:inventory_manager/inventory_manager.dart';

class Product extends ProductBasic {
  const Product({
    required super.id,
    required super.title,
    required super.code,
    required super.defaultPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'defaultPrice': defaultPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      code: map['code'] as String,
      defaultPrice: double.parse(map['defaultPrice'].toString()),
    );
  }
}
