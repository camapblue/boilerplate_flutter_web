import 'dart:async';

import 'package:boilerplate_flutter_web/modules/boilerplate_web_app.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () => runZonedGuarded(() {
      runApp(const BoilerplateWebApp());
    }, (error, stackTrace) {
      debugPrint('>>>>> ${error.toString()}');
    }),
    blocObserver: SimpleBlocObserver(),
  );
}
