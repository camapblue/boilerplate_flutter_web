enum AppIcons {
  error,
  placeholder,
  empty,
  info,
}

const _AppIconsAsset = {
  AppIcons.error: 'assets/icons/error.svg',
  AppIcons.placeholder: 'assets/icons/placeholder.svg',
  AppIcons.empty: 'assets/icons/empty.svg',
  AppIcons.info: 'assets/icons/info.svg',
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