import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';

class XIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? child;
  final double? iconSize;
  final double? minWidth;
  final Color? iconColor;
  final BoxBorder? border;
  final Color? background;
  final VoidCallback? onPressed;

  const XIconButton({
    Key? key,
    this.icon,
    this.child,
    this.border,
    this.minWidth,
    this.iconSize,
    this.onPressed,
    this.iconColor,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border,
      ),
      child: IconButton(
        onPressed: onPressed,
        splashRadius: (minWidth ?? 45) - 25,
        iconSize: iconSize ?? 22,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          minWidth: minWidth ?? 45,
          minHeight: minWidth ?? 45,
        ),
        icon: child ??
            Icon(
              icon,
              color: iconColor ?? context.iconColor,
            ),
      ),
    );
  }
}
