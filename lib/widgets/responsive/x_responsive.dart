import 'package:flutter/material.dart';

class XResponsiveWidget extends StatelessWidget {
  final Widget? webLayout;
  final Widget? mobileLayout;
  final Widget child;

  const XResponsiveWidget({
    Key? key,
    required this.child,
    this.webLayout,
    this.mobileLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return webLayout ?? child;
        } else {
          return mobileLayout ?? child;
        }
      },
    );
  }
}
