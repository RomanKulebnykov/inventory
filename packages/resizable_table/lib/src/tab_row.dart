import 'package:flutter/material.dart';
import 'tab_cell.dart';

/// ===================================================================== TabRow
class TabRow {
  final List<TabCell> cells;

  TabRow({required this.cells, required this.onTap});
  final void Function() onTap;
}

/// ================================================================= TabRowView
class TabRowView extends StatelessWidget {
  const TabRowView({
    super.key,
    required this.cells,
    this.hasDivider = true,
    required this.onTap,
  });

  final List<TabCellView> cells;
  final bool hasDivider;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          radius: 130,
          onTap: onTap,
          onHover: (value) {
            print('object');
          },
          child: MediaQuery(
            data: MediaQueryData(textScaleFactor: 0.9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: cells,
            ),
          ),
        ),
        if (hasDivider) const Divider(),
      ],
    );
  }
}
