import 'package:flutter/material.dart';

import 'x_responsive.dart';
import 'x_state_widget.dart';

part 'x_one_column_responsive.dart';
part 'x_two_column_responsive.dart';

abstract class XResponsiveTemplateWidget<T extends StatefulWidget>
    extends XStateWidget<T> {
  @override
  Widget buildContentView(BuildContext context) {
    return XResponsiveWidget(
      webLayout: webLayout(context),
      child: mobileLayout(context),
    );
  }

  Widget mobileLayout(BuildContext context) => const SizedBox();

  Widget webLayout(BuildContext context) => const SizedBox();
}
