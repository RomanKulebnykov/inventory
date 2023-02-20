import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'resizable_table_view_model.dart';

/// ================================================================ TabHeadCell
class TabHeadCell {
  final String idLabel;
  final Widget element;
  final double minWidth;
  final double maxWidth;
  final double? fixedWidth;
  final bool isPinned;
  bool isShow;
  double width;

  TabHeadCell({
    required this.idLabel,
    required this.element,
    this.isPinned = false,
    this.isShow = true,
    this.minWidth = 50,
    this.maxWidth = 200,
    this.fixedWidth,
    double? width,
  }) : width = fixedWidth ?? correctWidth(width, minWidth, maxWidth);

  static double correctWidth(double? prefferedW, double minW, double maxW) {
    if (prefferedW != null) {
      if (prefferedW < maxW && prefferedW > minW) {
        return prefferedW;
      } else if (prefferedW > maxW) {
        return maxW;
      } else if (prefferedW < minW) {
        return minW;
      }
    }
    return (minW + maxW) / 2;
  }
}

/// ============================================================ TabHeadCellView
class TabHeadCellView extends StatefulWidget {
  const TabHeadCellView({
    Key? key,
    required this.element,
    required this.width,
    required this.minWidth,
    required this.maxWidth,
    this.isSHowDragElement = true,
    this.textPadding = 8,
    required this.isEnable,
    required this.isPinned,
    required this.idLabel,
    // this.onWidthUpdateFinish,
    // this.onWidthUpdate,
  }) : super(key: key);

  final String idLabel;
  final Widget element;
  final double width;
  final double minWidth;
  final double maxWidth;
  final bool isSHowDragElement;
  final double textPadding;
  final bool isEnable;
  final bool isPinned;
  // final void Function(double newWidth)? onWidthUpdate;
  // final void Function()? onWidthUpdateFinish;

  @override
  State<TabHeadCellView> createState() => _TabHeadCellViewState();
}

class _TabHeadCellViewState extends State<TabHeadCellView> {
  @override
  void initState() {
    super.initState();
    width = widget.width;
  }

  late double width;
  bool onEnter = false;
  bool onDrag = false;
  @override
  Widget build(BuildContext context) {
    if (!widget.isEnable) return Container();
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.minWidth,
        maxWidth: widget.maxWidth,
      ),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.textPadding),
                child: widget.element,
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              onEnter: (v) {
                onEnter = false;
                // print('onEnter');
              },
              onExit: (v) {
                onEnter = false;
                // print('onExit');
              },
              child: GestureDetector(
                onHorizontalDragStart: (detail) {
                  setState(() {
                    onDrag = true;
                  });

                  // print(detail);
                },
                onHorizontalDragEnd: (detail) {
                  context
                      .read<ResizableTableViewModel>()
                      .onColumnWidthUpdateFinish(widget.idLabel, width);

                  setState(() => onDrag = false);
                },
                onHorizontalDragUpdate: (detail) {
                  double newValue = width + detail.delta.dx;
                  // print(newValue);
                  if (newValue < widget.maxWidth &&
                      newValue > widget.minWidth) {
                    setState(() => width = newValue);

                    context
                        .read<ResizableTableViewModel>()
                        .onColumnWidthUpdate(widget.idLabel, newValue);
                  }
                },
                child: Container(
                  width: widget.isSHowDragElement ? 3 : 0,
                  color: onDrag ? Colors.blue : Colors.blue.withAlpha(100),
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
