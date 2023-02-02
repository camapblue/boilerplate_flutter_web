import 'package:flutter/material.dart';

extension AppContext on BuildContext {
  
  ThemeData get theme => Theme.of(this);

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

  Color get backgroundColor => theme.colorScheme.background;

  Color get disabledColor => theme.disabledColor;

  Color get disabledBackgroundColor => theme.disabledColor.withOpacity(.2);

  Color? get textColor => theme.textTheme.labelLarge?.color;

  Color? get iconColor => theme.iconTheme.color;

  Color get backgroundSubdued => const Color(0XFFF4F4F5);

  Color get primarySubdued => const Color(0XFF9ED2FF);

  Color get onBackgroundColor => theme.colorScheme.onBackground;

  Color get textColorDisabled => theme.disabledColor.withOpacity(0.35);

  Color get primaryColorDark => theme.colorScheme.primaryContainer;
}