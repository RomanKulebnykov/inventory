import 'package:flutter/material.dart';

class TabCell {
  TabCell({required this.element});
  final Widget element;
}

class TabCellView extends StatelessWidget {
  const TabCellView({
    Key? key,
    required this.width,
    required this.element,
    required this.isShow,
  }) : super(key: key);

  final double textElementPadding = 8;
  final bool isShow;
  final double width;
  final Widget element;

  @override
  Widget build(BuildContext context) {
    if (!isShow) return Container();
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: textElementPadding),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: element,
        ),
      ),
    );
  }
}
