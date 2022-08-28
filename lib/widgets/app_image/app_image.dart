import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
  }) : super(key: key);

  final String image;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          AppImagesAsset.defaultAvatar,
          width: width,
          height: height,
        );
      },
    );
  }
}
