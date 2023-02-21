import 'package:flutter/material.dart';
import 'tab_cell.dart';

/// ===================================================================== TabRow
class TabRow {
  final List<TabCell> cells;

  TabRow({
    required this.cells,
    required this.onTap,
    this.heightLightListColor = Colors.white54,
  });
  final Color heightLightListColor;
  final void Function() onTap;
}

/// ================================================================= TabRowView
class TabRowView extends StatefulWidget {
  const TabRowView({
    super.key,
    required this.cells,
    this.hasDivider = true,
    required this.onTap,
    required this.heightLightListColor,
  });

  final List<TabCellView> cells;
  final bool hasDivider;
  final void Function() onTap;
  final Color heightLightListColor;

  @override
  State<TabRowView> createState() => _TabRowViewState();
}

class _TabRowViewState extends State<TabRowView> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    final basicScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          radius: 130,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: widget.onTap,
          onHover: (value) {
            setState(() => isHover = value);
          },
          child: DefaultTextStyle(
            style: isHover
                ? TextStyle(color: widget.heightLightListColor)
                : DefaultTextStyle.of(context).style,
            child: MediaQuery(
              data: MediaQueryData(
                textScaleFactor:
                    isHover ? basicScaleFactor + 0.05 : basicScaleFactor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.cells,
              ),
            ),
          ),
        ),
        if (widget.hasDivider) const Divider(),
      ],
    );
  }
}
