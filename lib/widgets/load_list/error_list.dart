import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'load_list_theme.dart';

class ErrorList extends StatelessWidget {
  const ErrorList({
    Key? key,
    required this.errorMessage,
    required this.doReload,
  }) : super(key: key);

  final GestureTapCallback? doReload;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          const Spacer(),
          const SizedBox(
            height: 32,
            child: Center(
              child: AppIcon(
                icon: AppIcons.error,
                width: 32,
                height: 32,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).loadListErrorMessageTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Button.reload(
            context: context,
            onPressed: doReload,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
