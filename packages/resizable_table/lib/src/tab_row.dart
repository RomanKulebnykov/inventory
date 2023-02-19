import 'dart:math';

import 'package:flutter/material.dart';
import 'tab_cell.dart';

class TabRow {
  final List<TabCell> cells;

  TabRow({required this.cells});
}

class TabRowView extends StatelessWidget {
  const TabRowView({
    super.key,
    required this.cells,
    this.hasDivider = true,
  });

  final List<TabCellView> cells;
  final bool hasDivider;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: cells,
        ),
        if (hasDivider) const Divider(),
      ],
    );
  }
}
