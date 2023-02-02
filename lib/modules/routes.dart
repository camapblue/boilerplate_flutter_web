// ignore_for_file: unnecessary_lambdas

import 'dart:async';

import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:common/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';

import 'log_in/log_in_view.dart' deferred as log_in;
import 'dashboard/dashboard_view.dart' deferred as dashboard;
import 'error/error_view.dart' deferred as error;
import 'splash/splash_view.dart' deferred as splash;

class AppRouter {
  static void initialize() {
    QR.settings.notFoundPage = QRoute(
      path: '/404',
      builder: () => error.ErrorView(),
      middleware: [DeferredLoader(error.loadLibrary)],
    );

    QR.settings.pagesType = QCustomPage(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );

    QR.setUrlStrategy();
  }

  static List<QRoute> allRoutes() {
    return <QRoute>[
      QRoute(
        path: RouteName.main,
        name: RouteName.main,
        builder: () => splash.SplashView(),
        middleware: [DeferredLoader(splash.loadLibrary)],
      ),
      QRoute(
        path: RouteName.Dashboard.path,
        name: RouteName.Dashboard.name,
        builder: () => MultiBlocProvider(
          providers: [
            Provider().BlocProvider.userList(Keys.Blocs.userListBloc),
          ],
          child: dashboard.DashboardView(),
        ),
        middleware: [
          DeferredLoader(dashboard.loadLibrary),
          AuthorizationValidation(true),
        ],
      ),
      QRoute(
        path: RouteName.LogIn.path,
        name: RouteName.LogIn.name,
        builder: () => BlocProvider<SignInBloc>(
          create: (_) => SignInBloc.instance(),
          child: log_in.LogInView(),
        ),
        middleware: [
          DeferredLoader(log_in.loadLibrary),
          AuthorizationValidation(false),
        ],
      ),
    ];
  }
}

class AuthorizationValidation extends QMiddleware {
  final bool authenticated;
  AuthorizationValidation(this.authenticated);

  @override
  Future onEnter() async {
    final bloc = EventBus().blocFromKey<SessionBloc>(Keys.Blocs.sessionBloc);
    final isSignedIn = bloc?.isSignedIn ?? false;
    
    if (authenticated && !isSignedIn) {
      unawaited(AppRouting().go(RouteName.LogIn.path));
    } else if (!authenticated && isSignedIn) {
      unawaited(AppRouting().go(RouteName.Dashboard.path));
    }
  }
}
