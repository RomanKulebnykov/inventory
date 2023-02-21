import 'package:flutter/material.dart';

class TabCell {
  TabCell({required this.idColumn, required this.element});
  final String idColumn;
  final Widget element;
}

class TabCellView extends StatelessWidget {
  const TabCellView({
    Key? key,
    required this.width,
    required this.element,
    required this.isShow,
    required this.height,
  }) : super(key: key);

  final double elementPadding = 8;
  final bool isShow;
  final double width;
  final double height;
  final Widget element;

  @override
  Widget build(BuildContext context) {
    if (!isShow) return Container();
    return SizedBox(
      width: width,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: elementPadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(child: element),
          ),
        ),
      ),
    );
  }
}
