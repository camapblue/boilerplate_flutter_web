import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';

extension LoadListTheme on ThemeData {
  TextStyle get loadListEmptyMessageTextStyle =>
      primaryTextTheme.bodyText1.copyWith(color: darkColor);

  TextStyle get loadListErrorMessageTextStyle =>
      primaryTextTheme.bodyText1.copyWith(color: darkColor);
}
