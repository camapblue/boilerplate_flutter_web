import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/modules/home/home_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> allRoutes(BuildContext context) {
    return {
      Pages.home: (context) => const HomeView(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.home:
        return _getPageRoute(const HomeView());
      default:
        return _getPageRoute(const HomeView());
    }
  }

  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(
      builder: (context) => child,
    );
  }
}
