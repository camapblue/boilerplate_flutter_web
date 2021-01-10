import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  AppImage({
    Key key,
    @required this.image,
    this.width,
    this.height,
  }) : super(key: key);

  final String image;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(image),
      width: width,
      height: height,
    );
  }
}
