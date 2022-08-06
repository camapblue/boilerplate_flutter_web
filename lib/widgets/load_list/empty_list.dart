import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'load_list_theme.dart';

class EmptyList extends StatelessWidget {
  final String emptyMessage;
  final Color color;
  final GestureTapCallback? onReload;

  const EmptyList({
    Key? key,
    required this.emptyMessage,
    this.color = Colors.white,
    this.onReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 64,
            child: Center(
              child: AppIcon(
                icon: AppIcons.empty,
                width: 92,
                height: 92,
                color: color,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: Text(
              emptyMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .loadListEmptyMessageTextStyle
                  .copyWith(color: color),
            ),
          ),
          if (onReload != null)
            SizedBox(
              width: 100,
              child: Button.reload(
                context: context,
                onPressed: onReload,
              ),
            )
        ],
      ),
    );
  }
}
