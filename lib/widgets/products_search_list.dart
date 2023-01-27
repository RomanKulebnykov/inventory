import 'package:flutter/material.dart';

import '../models/order_item.dart';
import '../pages/screens/inventory_orders_screen/widgets/list_tile_inventory.dart';

class ProductSearchList extends StatelessWidget {
  const ProductSearchList({
    Key? key,
    required this.orderItems,
    required this.onItemUpdated,
  }) : super(key: key);

  final List<OrderItem> orderItems;
  final void Function(OrderItem newValue) onItemUpdated;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orderItems.length,
      itemBuilder: (context, index) {
        return ListTileInventory(
          orderItem: orderItems[index],
          onChange: onItemUpdated,
        );
      },
    );
  }
}
