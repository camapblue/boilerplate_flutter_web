import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class XImageNetwork extends StatelessWidget {
  const XImageNetwork({
    Key? key,
    required this.imagePath,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.fit,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String imagePath;
  final BorderRadius? borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      imageWidget = _buildImageNetwork(context);
    } else {
      imageWidget = _buildEmptyImage(context);
    }

    return borderRadius != null
        ? ClipRRect(
            borderRadius: borderRadius,
            child: imageWidget,
          )
        : imageWidget;
  }

  Widget _buildImageNetwork(BuildContext context) {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.cover,
      imageUrl: imagePath,
      width: width,
      height: height,
      placeholder: (_, __) => Container(
        width: width,
        height: height,
        color: Colors.white70,
      ),
      errorWidget: (context, url, error) => AppImage(
        image: AppImagesAsset.defaultAvatar,
        width: width ?? 100.0,
        height: height ?? 100.0,
      ),
    );
  }

  Widget _buildEmptyImage(BuildContext context) {
    return Image.asset(
      AppImagesAsset.defaultAvatar,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
