import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/modules/home/home_view.dart';
import 'package:boilerplate_flutter_web/modules/league/league_view.dart';
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
        return _getPageRoute(const HomeView(), settings);
      case Pages.league: {
        return _getPageRoute(const LeagueView(), settings);
      }
      default:
        return _getPageRoute(const HomeView(), settings);
    }
  }

  static PageRoute _getPageRoute(Widget child, RouteSettings settings) {
    return _FadeRouteTransition(
        pageBuilder: (context) => child,
        settings: settings,
        duration: const Duration(milliseconds: 250),
      );
  }
}

class _FadeRouteTransition<T> extends PageRoute<T> {
  final WidgetBuilder pageBuilder;
  final Duration duration;

  _FadeRouteTransition({
    @required this.pageBuilder,
    @required RouteSettings settings,
    this.duration,
  })  : assert(pageBuilder != null, 'Must provide page builder!'),
        super(settings: settings);

  @override
  Color get barrierColor => Colors.black.withAlpha(1);

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: pageBuilder(context),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration =>
      duration ?? const Duration(milliseconds: 300);

  @override
  bool get opaque => false;
}
