import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'toast_enum.dart';

class XToastWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final XToastEnum? type;
  final Function()? onClose;

  const XToastWidget({
    Key? key,
    this.title,
    this.description,
    this.type = XToastEnum.neutral,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case XToastEnum.negative:
        return _buildContentView(
          context,
          NotificationIcons.negative,
          context.errorColor,
        );
      case XToastEnum.positive:
        return _buildContentView(
          context,
          NotificationIcons.positive,
          context.secondaryColor,
        );
      default:
        return _buildContentView(
          context,
          NotificationIcons.neutral,
          context.primaryColor,
        );
    }
  }

  Widget _buildContentView(
    BuildContext context,
    NotificationIcons icon,
    Color color,
  ) {
    return Container(
      width: context.toastWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 5.0,
            offset: const Offset(0, -4), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(5.0),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 4.0, color: color)),
          ),
          child: Row(
            crossAxisAlignment:
                (title.isNotNullOrEmpty() && description.isNotNullOrEmpty())
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
            children: [
              Container(
                width: 30.0,
                height: 30.0,
                margin: const EdgeInsets.only(left: 8, top: 2),
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: color,
                ),
                child: Center(
                  child: AppIcon(
                    icon: icon.toAppIcon(),
                    width: 18.0,
                    height: 18.0,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title.isNotNullOrEmpty()) ...[
                      XText.titleLarge(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleLarge?.copyWith(fontSize: 16.0),
                      ),
                    ],
                    if (description.isNotNullOrEmpty()) ...[
                      XText.titleMedium(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              InkWell(
                onTap: onClose,
                child: AppIcon(
                  icon: NotificationIcons.close.toAppIcon(),
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
