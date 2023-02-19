import 'package:flutter/material.dart';

class TabHeadCell {
  final String idLabel;
  final String text;
  final double minWidth;
  final double maxWidth;
  final double? fixedWidth;
  bool isShow;
  double width;

  TabHeadCell({
    required this.idLabel,
    required this.text,
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

class TabHeadCellView extends StatefulWidget {
  const TabHeadCellView({
    Key? key,
    required this.text,
    required this.width,
    required this.minWidth,
    required this.maxWidth,
    this.isSHowDragElement = true,
    this.textPadding = 8,
    required this.isEnable,
    this.onWidthUpdateFinish,
    this.onWidthUpdate,
  }) : super(key: key);

  final String text;
  final double width;
  final double minWidth;
  final double maxWidth;
  final bool isSHowDragElement;
  final double textPadding;
  final bool isEnable;
  final void Function(double newWidth)? onWidthUpdate;
  final void Function()? onWidthUpdateFinish;

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
                child: Text(
                  widget.text,
                  overflow: TextOverflow.ellipsis,
                ),
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
                  if (widget.onWidthUpdateFinish != null) {
                    widget.onWidthUpdateFinish!();
                  }
                  setState(() {
                    onDrag = false;
                  });
                },
                onHorizontalDragUpdate: (detail) {
                  double newValue = width + detail.delta.dx;
                  // print(newValue);
                  if (newValue < widget.maxWidth &&
                      newValue > widget.minWidth) {
                    setState(() => width = newValue);
                    if (widget.onWidthUpdate != null) {
                      widget.onWidthUpdate!(newValue);
                    }
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
