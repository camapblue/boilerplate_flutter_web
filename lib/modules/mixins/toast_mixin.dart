import 'package:boilerplate_flutter_web/widgets/widgets.dart';

mixin ToastMixin {
  void showToast({String? title, required String message}) {
    XToast.showNeutralMessage(title: title ?? '', description: message);
  }
}