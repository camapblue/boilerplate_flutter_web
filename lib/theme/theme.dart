import 'package:flutter/material.dart';
import 'theme_constants.dart';

export 'theme_constants.dart';
export 'theme_text.dart';

ThemeData loadTheme({dynamic theme}) {
  return ThemeData(
    primaryColor: greenColor,
    primaryColorLight: greenColorLight,
    primaryTextTheme: appPrimaryTextTheme,
  );
}
