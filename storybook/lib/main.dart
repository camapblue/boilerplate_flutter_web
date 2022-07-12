import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_web/blocs/base/simple_bloc_observer.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';

import 'stories/stories.dart';
import 'storybook.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();

  runApp(
    Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          theme: loadTheme(),
          home: Storybook(
            [
              ButtonStory(), // Supermama
              MenuBarStory(),
            ],
          ),
        );
      },
    ),
  );
}
