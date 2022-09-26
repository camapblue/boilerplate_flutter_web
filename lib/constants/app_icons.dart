// ignore_for_file: constant_identifier_names

enum AppIcons {
  error,
  placeholder,
  empty,
  info,
  notificationClose,
  notificationNeutral,
  notificationPositive,
  notificationNegative,
}

const _AppIconsAsset = {
  AppIcons.error: 'assets/icons/error.svg',
  AppIcons.placeholder: 'assets/icons/placeholder.svg',
  AppIcons.empty: 'assets/icons/empty.svg',
  AppIcons.info: 'assets/icons/info.svg',
  AppIcons.notificationClose: 'assets/icons/notification_close.svg',
  AppIcons.notificationNegative: 'assets/icons/notification_negative.svg',
  AppIcons.notificationNeutral: 'assets/icons/notification_neutral.svg',
  AppIcons.notificationPositive: 'assets/icons/notification_positive.svg',
};

extension AppIconsExtension on AppIcons {
  String toAssetName() {
    final assets = _AppIconsAsset[this];
    if (assets != null) {
      return assets;
    }
    return 'assets/icons/placeholder.svg';
  }
}
