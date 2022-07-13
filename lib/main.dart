import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/modules/base/layout_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:boilerplate_flutter_web/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'blocs/blocs.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (_) =>
              ConnectivityBloc.instance()..add(ConnectivityChecked()),
        ),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc.instance())
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (_, state) {
          return MaterialApp(
            title: 'Boilerplate Flutter Web',
            localizationsDelegates: const [
              SLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('vi'),
              Locale('en'),
            ],
            locale: const Locale('en'),
            theme: loadTheme(theme: state.theme),
            home: const LayoutTemplate(),
          );
        },
      ),
    );
  }
}
