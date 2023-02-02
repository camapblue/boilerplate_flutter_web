import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? backgroundColor;
  final Widget child;

  const InkWellButton({
    Key? key,
    required this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(4),
    this.borderRadius = 4,
    this.highlightColor,
    this.backgroundColor,
    this.splashColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor ?? Colors.transparent,
        ),
        child: InkWell(
          onTap: onTap,
          highlightColor: highlightColor ?? Colors.white54,
          splashColor: splashColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
