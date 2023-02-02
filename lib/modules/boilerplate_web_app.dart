import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qlevar_router/qlevar_router.dart';

import '../blocs/blocs.dart';
import 'routes.dart';

class BoilerplateWebApp extends StatefulWidget {
  const BoilerplateWebApp({Key? key}) : super(key: key);

  @override
  State<BoilerplateWebApp> createState() => _BoilerplateWebAppState();
}

class _BoilerplateWebAppState extends State<BoilerplateWebApp> {
  final _botToastBuilder = BotToastInit();

  @override
  void initState() {
    super.initState();

    AppRouter.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionBloc>(
          create: (_) => SessionBloc.instance()..start(),
        ),
        BlocProvider<LanguageBloc>(
          create: (_) => LanguageBloc.instance(),
        )
      ],
      child: BlocListener<SessionBloc, SessionState>(
        listener: (_, state) {
          log.info('Session State >> $state');
          if (state is SessionLogOutSuccess) {
            AppRouting().pushReplacementNamed(RouteName.LogIn.name);
          } else if (state is SessionLoadSuccess) {
            AppRouting().pushReplacementNamed(RouteName.Dashboard.name);
          }
        },
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (_, languageState) {
            return MaterialApp.router(
              routeInformationParser: const QRouteInformationParser(),
              routerDelegate: QRouterDelegate(
                AppRouter.allRoutes(),
                observers: [
                  AppRouteObserver(),
                  BotToastNavigatorObserver(),
                ],
              ),
              useInheritedMediaQuery: true,
              title: 'Boilerplate Web App',
              theme: DefaultTheme().build(context),
              localizationsDelegates: const [
                SLocalizationsDelegate(),
              ],
              supportedLocales: languageState.supportedLocales,
              builder: _botToastBuilder,
              locale: languageState.locale,
              debugShowCheckedModeBanner: false,
              restorationScopeId: 'Boilerplate Web App',
            );
          },
        ),
      ),
    );
  }
}
