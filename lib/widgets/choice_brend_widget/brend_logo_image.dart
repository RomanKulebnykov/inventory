import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BrendLogoImage extends StatelessWidget {
  const BrendLogoImage({
    Key? key,
    this.url,
    this.width = 100,
    this.height = 60,
  }) : super(key: key);

  final String? url;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return Image.network(
        url!,
        width: width,
        height: height,
      );
    }
    return SizedBox(
      width: width,
      height: height,
      child: FaIcon(
        FontAwesomeIcons.images,
        size: height,
        color: Colors.grey,
      ),
    );
  }
}
