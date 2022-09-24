import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Size get device => MediaQuery.of(this).size;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// ----------- Screen size ----------- ///

  bool get isMobile => deviceWidth < 768;

  bool get isWeb => deviceWidth >= 768;

  double get deviceWidth => mediaQuery.size.width;

  double get deviceHeight => mediaQuery.size.height;

  double get toastWidth => mediaQuery.size.width * (isMobile ? 0.9 : 0.65);
}
