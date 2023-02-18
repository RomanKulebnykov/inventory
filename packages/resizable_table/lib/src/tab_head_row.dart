import 'package:flutter/material.dart';

import '../resizable_table.dart';

class TabHeadRow {
  final List<TabHeadCell> cells;

  TabHeadRow({required this.cells});
}

class TabHeadRowView extends StatelessWidget {
  const TabHeadRowView({
    super.key,
    required this.cells,
  });

  final List<TabHeadCellView> cells;
  @override
  Widget build(BuildContext context) {
    return Row(children: cells);
  }
}
