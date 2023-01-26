import 'package:inventory/models/product.dart';
import 'package:inventory_manager/inventory_manager.dart';

class OrderItemPresentation extends ItemBalance {
  final Product product;

  OrderItemPresentation({
    required this.product,
    required super.id,
    required super.price,
    required super.count,
  });
  // double price;
  // int count;

  OrderItemPresentation copyWith({
    Product? product,
    String? id,
    int? count,
    double? price,
  }) {
    return OrderItemPresentation(
      id: id ?? this.id,
      count: count ?? this.count,
      price: price ?? this.price,
      product: product ?? this.product,
    );
  }

  OrderItemPresentation.fromProductItem(Product product)
      : this(
          id: product.id,
          product: product,
          price: product.defaultPrice,
          count: 1,
        );

  @override
  List<Object?> get props => [product];
}
