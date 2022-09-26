import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'toast_enum.dart';
import 'x_toast_widget.dart';

class XToast {
  static void showNeutralMessage({
    required String title,
    required String description,
    List<dynamic>? actions,
  }) {
    return _show(title, description, type: XToastEnum.neutral);
  }

  static void showPositiveMessage({
    required String title,
    required String description,
    List<dynamic>? actions,
  }) {
    return _show(title, description, type: XToastEnum.positive);
  }

  static void showNegativeMessage({
    required String title,
    required String description,
    List<dynamic>? actions,
  }) {
    return _show(title, description, type: XToastEnum.negative);
  }

  static void _show(
    String? title,
    String? description, {
    required XToastEnum type,
  }) {
    const enableSlideOff = true;
    const onlyOne = true;
    const crossPage = true;
    const seconds = 3;
    const animationMilliseconds = 200;
    const animationReverseMilliseconds = 200;

    BotToast.showCustomNotification(
      toastBuilder: (_) => XToastWidget(
        title: title,
        description: description,
        type: type,
        onClose: () {
          BotToast.cleanAll();
        },
      ),
      animationDuration: const Duration(milliseconds: animationMilliseconds),
      animationReverseDuration:
          const Duration(milliseconds: animationReverseMilliseconds),
      duration: const Duration(seconds: seconds),
      onlyOne: onlyOne,
      crossPage: crossPage,
      backButtonBehavior: BackButtonBehavior.none,
      enableSlideOff: enableSlideOff,
      enableKeyboardSafeArea: true,
      align: const Alignment(0, -0.95),
    );
  }
}
