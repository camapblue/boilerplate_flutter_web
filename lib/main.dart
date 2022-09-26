import 'dart:async';

import 'package:boilerplate_flutter_web/modules/boilerplate_web_app.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    ),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    Repository().initialize(),
  ]);
  Bloc.observer = SimpleBlocObserver();

  runApp(const BoilerplateWebApp());
}
