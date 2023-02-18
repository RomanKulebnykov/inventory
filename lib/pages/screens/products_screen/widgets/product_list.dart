import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:resizable_table/resizable_table.dart';
import '../../../../utils/formatters.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return ResizableTable(
      columns: [
        TabHeadCell(text: 'head1'),
        TabHeadCell(text: 'head2'),
        TabHeadCell(text: 'head3'),
      ],
      rows: [
        TabRow(cells: [
          TabCell(text: 'v1f1'),
          TabCell(text: 'v1f2'),
          TabCell(text: 'v1f3'),
        ]),
        TabRow(cells: [
          TabCell(text: 'v2f1'),
          TabCell(text: 'v2f2'),
          TabCell(text: 'v2f3')
        ]),
        TabRow(cells: [
          TabCell(text: 'v3f1'),
          TabCell(text: 'v3f2'),
          TabCell(text: 'v3f3')
        ]),
        TabRow(cells: [
          TabCell(text: 'v4f1'),
          TabCell(text: 'v4f2'),
          TabCell(text: 'v4f3')
        ]),
        TabRow(cells: [
          TabCell(text: 'v5f1'),
          TabCell(text: 'v5f2'),
          TabCell(text: 'v5f3')
        ]),
      ],
    );
  }
}

class ProductStatsRow extends StatelessWidget {
  const ProductStatsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('Amount: 1'),
        SizedBox(width: 8),
        Text('Reserve: 0'),
        SizedBox(width: 8),
        Text('Pending: 0'),
      ],
    );
  }
}
