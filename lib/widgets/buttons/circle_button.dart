import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.onTap,
    required this.iconColor,
    required this.iconData,
    required this.filledColor,
    required this.borderColor,
  }) : super(key: key);

  final void Function() onTap;
  final Color iconColor;
  final Color filledColor;
  final Color borderColor;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: filledColor,
        shape: CircleBorder(
          side: BorderSide(color: borderColor, width: 2),
        ),
      ),
      child: IconButton(
        onPressed: onTap,
        color: iconColor,
        icon: Icon(iconData),
      ),
    );
  }
}
