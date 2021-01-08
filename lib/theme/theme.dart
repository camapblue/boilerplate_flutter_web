import 'package:flutter/material.dart';
import 'theme_constants.dart';

export 'theme_constants.dart';
export 'theme_text.dart';

ThemeData loadTheme() {
  return ThemeData(
    primaryColor: greenColor,
    primaryColorLight: greenColorLight,
    primaryTextTheme: appPrimaryTextTheme,
  );
}
