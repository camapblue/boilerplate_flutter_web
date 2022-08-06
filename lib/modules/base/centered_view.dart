import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class _CenteredViewMobile extends StatelessWidget {
  final Widget child;
  const _CenteredViewMobile({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: child,
    );
  }
}

class _CenteredViewTabletDesktop extends StatelessWidget {
  final Widget child;
  const _CenteredViewTabletDesktop({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 60),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: child,
      ),
    );
  }
}

class CenteredView extends StatelessWidget {
  final Widget child;
  const CenteredView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _CenteredViewMobile(child: child),
      tablet: _CenteredViewTabletDesktop(child: child),
    );
  }
}
