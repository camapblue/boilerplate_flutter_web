import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';
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
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc.instance(),
        )
      ],
      child: BlocListener<SessionBloc, SessionState>(
        listener: (_, state) {
          log.info('Session State >> $state');
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (_, state) {
          return MaterialApp.router(
            routeInformationParser: const QRouteInformationParser(),
            routerDelegate: QRouterDelegate(
              AppRouter.allRoutes(),
              observers: [
                AppRouteObserver(),
              ],
            ),
            useInheritedMediaQuery: true,
            title: 'Boilerplate Web App',
            theme: state.theme != null
                ? loadTheme(theme: state.theme)
                : DefaultTheme().build(context),
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'Boilerplate Web App',
          );
        }),
      ),
    );
  }
}
