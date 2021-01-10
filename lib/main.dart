import 'package:boilerplate_flutter_web/modules/base/layout_template.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:boilerplate_flutter_web/theme/theme.dart';
import 'blocs/blocs.dart';

Future<void> main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  
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
      ],
      child: MaterialApp(
        title: 'Boilerplate Flutter Web',
        theme: loadTheme(),
        home: const LayoutTemplate(),
      ),
    );
  }
}
