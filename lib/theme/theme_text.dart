import 'package:flutter/material.dart';

extension TextThemeData on ThemeData {
  // Tabbar Menu
  TextStyle get bottomTabbarTextStyle => primaryTextTheme.headline1;

  // Loading Text
  TextStyle get loadingTextStyle => primaryBold;

  // Primary style
  TextStyle get primaryRegular => primaryTextTheme.bodyText1;
  TextStyle get primaryBold => primaryTextTheme.headline1;
  TextStyle get primaryItalic => primaryTextTheme.bodyText2;
  TextStyle get primaryBoldItalic => primaryTextTheme.headline2;
  TextStyle get primaryButton => primaryTextTheme.button;
}