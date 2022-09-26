import 'package:boilerplate_flutter_web/constants/constants.dart';

enum XToastEnum { positive, negative, neutral }

enum NotificationIcons { positive, negative, neutral, close }

extension NotificationIconsExtenstion on NotificationIcons {
  AppIcons toAppIcon() {
    switch (this) {
      case NotificationIcons.positive: return AppIcons.notificationPositive;
      case NotificationIcons.negative: return AppIcons.notificationNegative;
      case NotificationIcons.neutral: return AppIcons.notificationNeutral;
      case NotificationIcons.close: return AppIcons.notificationClose;
    }
  }
}
