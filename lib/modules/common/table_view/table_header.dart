import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';

class TableHeader extends StatelessWidget {
  final String text;
  final bool showDivider;

  const TableHeader({
    super.key,
    required this.text,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.primaryColor,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: XText.labelMedium(
                text,
                style: context.labelMedium?.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
            showDivider
                ? const VerticalDivider(
                    color: AppColors.white,
                    thickness: 1,
                    width: 1,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
