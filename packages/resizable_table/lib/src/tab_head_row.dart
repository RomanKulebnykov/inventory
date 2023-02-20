import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resizable_table/src/resizable_table_view_model.dart';

import '../resizable_table.dart';

/// ================================================================= TabHeadRow
class TabHeadRow {
  final List<TabHeadCell> cells;

  TabHeadRow({required this.cells});
}

/// ============================================================= TabHeadRowView
class TabHeadRowView extends StatelessWidget {
  const TabHeadRowView({
    super.key,
    required this.cells,
  });

  final List<TabHeadCellView> cells;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        onReorder: context.read<ResizableTableViewModel>().onReorder,
        itemCount: cells.length,
        itemBuilder: (context, index) {
          final headCell = cells[index];
          return ReorderableDragStartListener(
            key: ValueKey(headCell.key),
            enabled: !headCell.isPinned,
            index: index,
            child: Container(color: Colors.transparent, child: headCell),
          );
        },
      ),
    );
    // return Row(children: cells);
  }
}
