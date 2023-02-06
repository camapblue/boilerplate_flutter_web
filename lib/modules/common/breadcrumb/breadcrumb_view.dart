import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/global/app_routing.dart';
import 'package:boilerplate_flutter_web/models/models.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';

part 'breadcrumb_item.dart';

class BreadcrumbView extends StatefulWidget {
  final List<BreadcrumbPage> data;
  final TextStyle normalStyle;
  final TextStyle highlightStyle;
  final TextStyle selectedStyle;
  final void Function(BreadcrumbPage, int)? onPageSelected;

  const BreadcrumbView({
    super.key,
    required this.data,
    this.normalStyle = const TextStyle(),
    this.highlightStyle = const TextStyle(
      color: Colors.indigo,
      decoration: TextDecoration.underline,
    ),
    this.selectedStyle = const TextStyle(
      fontWeight: FontWeight.w600,
    ),
    required this.onPageSelected,
  });

  @override
  State<BreadcrumbView> createState() => _BreadcrumbViewState();
}

class _BreadcrumbViewState extends State<BreadcrumbView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.data.mapIndex(
            (e, index) {
              return BreadcrumbItem(
                breadcrumb: e,
                isLast: widget.data.last == e,
                normalStyle: widget.normalStyle,
                highlightStyle: widget.highlightStyle,
                selectedStyle: widget.selectedStyle,
                onPageSelected: (item) {
                  if (widget.onPageSelected != null) {
                    widget.onPageSelected!(item, index);
                  } else {
                    AppRouting().goWithHiddenParams(
                      item.linkTo,
                      params: item.params,
                      includesCurrentParams: true,
                      includesHiddenParams: true,
                    );
                  }
                },
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
