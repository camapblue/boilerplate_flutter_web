import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Size get device => MediaQuery.of(this).size;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  /// ----------- Colors ----------- ///

  Color get primaryColor => theme.colorScheme.primary;

  Color get secondaryColor => theme.colorScheme.secondary;

  Color get errorColor => theme.colorScheme.error;

  Color get shimmerBaseColor => theme.colorScheme.primary;

  Color get shimmerHighlightColor => theme.colorScheme.primary;

  Color get dividerColor => theme.dividerColor;

  Color get onPrimary => theme.colorScheme.onPrimary;

  Color get onSecondary => theme.colorScheme.onSecondary;

  Color get cardColor => theme.cardColor;

  Color get unselectedWidgetColor => theme.unselectedWidgetColor;

  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  Color get backgroundColor => theme.backgroundColor;

  Color get disabledColor => theme.disabledColor;

  Color get disabledBackgroundColor => theme.disabledColor.withOpacity(.2);

  Color? get textColor => theme.textTheme.labelLarge?.color;

  Color? get iconColor => theme.iconTheme.color;

  /// ----------- Screen size ----------- ///

  bool get isMobile => deviceWidth < 768;

  bool get isWeb => deviceWidth >= 768;

  double get deviceWidth => mediaQuery.size.width;

  double get deviceHeight => mediaQuery.size.height;

  double get toastWidth => mediaQuery.size.width * (isMobile ? 0.9 : 0.65);

  /// ----------- Text style ----------- ///

  TextStyle? get displayLarge => theme.textTheme.displayLarge;

  TextStyle? get displayMedium => theme.textTheme.displayMedium;

  TextStyle? get displaySmall => theme.textTheme.displaySmall;

  TextStyle? get headlineLarge => theme.textTheme.headlineLarge;

  TextStyle? get headlineMedium => theme.textTheme.headlineMedium;

  TextStyle? get headlineSmall => theme.textTheme.headlineSmall;

  TextStyle? get titleLarge => theme.textTheme.titleLarge;

  TextStyle? get titleMedium => theme.textTheme.titleMedium;

  TextStyle? get titleSmall => theme.textTheme.titleSmall;

  TextStyle? get bodyLarge => theme.textTheme.bodyLarge;

  TextStyle? get bodyMedium => theme.textTheme.bodyMedium;

  TextStyle? get bodySmall => theme.textTheme.bodySmall;

  TextStyle? get labelLarge => theme.textTheme.labelLarge;

  TextStyle? get labelMedium => theme.textTheme.labelMedium;

  TextStyle? get labelSmall => theme.textTheme.labelSmall;
}
