import 'package:flutter/material.dart';

class TabCell {
  TabCell({required this.text});
  final String text;
}

class TabCellView extends StatelessWidget {
  const TabCellView({
    Key? key,
    this.width = 100,
    required this.text,
    this.isShow = true,
  }) : super(key: key);

  final double textElementPadding = 8;
  final bool isShow;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (!isShow) return Container();
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: textElementPadding),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(text),
        ),
      ),
    );
  }
}
