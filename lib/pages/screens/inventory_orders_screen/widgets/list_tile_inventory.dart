import 'package:flutter/material.dart';

import '../../../../models/order_item_presentation.dart';
import '../../../../widgets/buttons/increment_button.dart';

class ListTileInventory extends StatelessWidget {
  const ListTileInventory({
    Key? key,
    required this.orderItem,
    required this.onChange,
  }) : super(key: key);

  final OrderItemPresentation orderItem;
  final void Function(OrderItemPresentation updItem) onChange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      subtitle: const Divider(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(orderItem.product.title),
          Row(
            children: [
              SizedBox(
                width: 150,
                child: TextFormField(
                  initialValue: orderItem.price.toString(),
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(),
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IncrementButton(
                value: orderItem.count,
                onChange: (value) {
                  onChange(orderItem.copyWith(count: value));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
