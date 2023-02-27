import 'package:flutter/material.dart';
import 'package:inventory/models/order_inventory_presentation.dart';
import 'package:resizable_table/resizable_table.dart';

class OrderInventoryEnterList extends StatelessWidget {
  const OrderInventoryEnterList({super.key, required this.orders});

  final List<OrderInventoryEnterPresentation> orders;
  @override
  Widget build(BuildContext context) {
    return ResizableTable(
      withDividers: true,
      columns: [
        TabHeadCell(
          element: CellCheckBox(value: false, onChange: (value) {}),
          idLabel: 'check',
          fixedWidth: 52,
          isPinned: true,
        ),
        TabHeadCell(
          element: const CellText(text: 'ID'),
          idLabel: 'id',
          fixedWidth: 50,
          isPinned: true,
        ),
      ],
      rows: [
        for (final order in orders)
          TabRow(
            cells: [
              TabCell(
                idColumn: 'check',
                element: CellCheckBox(value: false, onChange: (value) {}),
              ),
              TabCell(
                idColumn: 'id',
                element: Text(order.id),
              ),
            ],
            onTap: () {},
          )
      ],
    );
  }
}
