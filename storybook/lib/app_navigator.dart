import 'package:flutter/material.dart';

class AppNavigator {
  static final AppNavigator _singleton = AppNavigator._internal();

  factory AppNavigator() {
    return _singleton;
  }

  AppNavigator._internal();

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) async {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}