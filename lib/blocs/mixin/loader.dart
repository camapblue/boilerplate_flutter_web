

import 'package:bot_toast/bot_toast.dart';

mixin Loader {
  void showGlobalLoading() {
    // need customize UI if needed
    BotToast.showLoading();
  }

  void hideGlobalLoading() {
    BotToast.closeAllLoading();
  }
}