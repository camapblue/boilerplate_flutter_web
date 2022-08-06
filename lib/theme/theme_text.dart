import 'package:flutter/material.dart';

import 'theme_constants.dart';

extension TextThemeData on ThemeData {
  // Tabbar Menu
  TextStyle get bottomTabbarTextStyle =>
      textTheme.headline1 ?? appPrimaryTextTheme.headline1!;

  // Loading Text
  TextStyle get loadingTextStyle => primaryBold;

  // Primary style
  TextStyle get primaryRegular =>
      textTheme.bodyMedium ?? appPrimaryTextTheme.bodyText1!;
  TextStyle get primaryBold =>
      textTheme.bodyLarge ?? appPrimaryTextTheme.headline1!;
  TextStyle get primaryItalic =>
      textTheme.bodyText1 ?? appPrimaryTextTheme.bodyText2!;
  TextStyle get primaryBoldItalic =>
      textTheme.bodySmall ?? appPrimaryTextTheme.headline2!;
  TextStyle get primaryButton =>
      textTheme.bodyMedium ?? appPrimaryTextTheme.bodyText1!;
}
