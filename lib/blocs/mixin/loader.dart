import 'package:bot_toast/bot_toast.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';

mixin Loader {
  void showGlobalLoading() {
    // need customize UI if needed
    BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) => Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black54,
        ),
        child: Center(
          child: JumpingDotsProgressIndicator(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void hideGlobalLoading() {
    BotToast.closeAllLoading();
  }
}
