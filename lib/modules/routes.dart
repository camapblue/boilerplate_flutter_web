// ignore_for_file: unnecessary_lambdas

import 'dart:async';

import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/models/models.dart';
import 'package:common/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:repository/model/model.dart';

import 'log_in/log_in_view.dart' deferred as log_in;
import 'dashboard/dashboard_view.dart' deferred as dashboard;
import 'user_list/user_list_view.dart' deferred as user_list;
import 'user_detail/user_detail_view.dart' deferred as user_detail;
import 'settings/settings_view.dart' deferred as settings;
import 'error/error_view.dart' deferred as error;
import 'splash/splash_view.dart' deferred as splash;

import 'breadcrumb_pages.dart';

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
      QRoute.withChild(
        path: RouteName.Dashboard.path,
        name: RouteName.Dashboard.name,
        initRoute: RouteName.Users.name,
        builderChild: (child) => dashboard.DashboardView(child),
        middleware: [
          DeferredLoader(dashboard.loadLibrary),
          AuthorizationValidation(true),
        ],
        children: [
          QRoute.withChild(
              path: RouteName.Users.path,
              name: RouteName.Users.name,
              builderChild: (child) {
                return child;
              },
              children: [
                QRoute(
                  path: '/',
                  builder: () {
                    return MultiBlocProvider(
                      providers: [
                        Provider()
                            .BlocProvider
                            .userList(Keys.Blocs.userListBloc),
                      ],
                      child: user_list.UserListView(),
                    );
                  },
                  middleware: [
                    DeferredLoader(user_list.loadLibrary),
                    BreadcrumbHandler(
                      page: BreadcrumbPages.users,
                    ),
                  ],
                ),
                QRoute(
                  path: RouteName.UserDetail.path,
                  name: RouteName.UserDetail.name,
                  builder: () {
                    final user = QR.params['user']?.valueAs<User>();
                    final userId = QR.params['userId'].toString();

                    return BlocProvider<UserDetailsBloc>(
                      create: (_) => UserDetailsBloc.instance(userId),
                      child: user_detail.UserDetailView(
                        user: user,
                        userId: userId,
                      ),
                    );
                  },
                  middleware: [
                    DeferredLoader(user_detail.loadLibrary),
                    BreadcrumbHandler(
                      page: BreadcrumbPages.userDetail,
                    ),
                  ],
                ),
              ]),
          QRoute(
            path: RouteName.Settings.path,
            name: RouteName.Settings.name,
            builder: () {
              return settings.SettingsView();
            },
            middleware: [
              DeferredLoader(settings.loadLibrary),
              BreadcrumbHandler(
                page: BreadcrumbPages.settings,
              ),
            ],
          ),
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

class BreadcrumbHandler extends QMiddleware {
  final BreadcrumbPages page;

  BreadcrumbHandler({
    required this.page,
  });

  @override
  Future onEnter() async {
    var pages = <BreadcrumbPage>[];

    switch (page) {
      case BreadcrumbPages.users:
        pages = [BreadcrumbPages.users.build()];
        break;
      case BreadcrumbPages.settings:
        pages = [
          BreadcrumbPages.settings.build(),
        ];
        break;
      case BreadcrumbPages.userDetail:
        final user = QR.params['user']?.valueAs<User>();
        final userId = QR.params['userId'].toString();
        pages = [
          BreadcrumbPages.users.build(),
          BreadcrumbPages.userDetail
              .build(data: {'userId': userId, 'user': user}),
        ];
        break;
    }

    EventBus().event<BreadcrumbBloc>(
      Keys.Blocs.breadcrumbBloc,
      BreadcrumbSet(pages),
      retryLater: true,
    );
  }
}
