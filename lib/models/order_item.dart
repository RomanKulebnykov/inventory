import 'package:inventory_manager/inventory_manager.dart';
import 'package:products_manager/products_manager.dart';

class OrderItem extends ItemBalance {
  final Product product;

  OrderItem({
    required this.product,
    required super.id,
    required super.price,
    required super.count,
  });
  // double price;
  // int count;

  OrderItem copyWith({
    Product? product,
    String? id,
    int? count,
    double? price,
  }) {
    return OrderItem(
      id: id ?? this.id,
      count: count ?? this.count,
      price: price ?? this.price,
      product: product ?? this.product,
    );
  }

  OrderItem.fromProductItem(Product product)
      : this(
          id: product.id,
          product: product,
          price: product.entryPrice,
          count: 1,
        );

  @override
  List<Object?> get props => [product];
}
