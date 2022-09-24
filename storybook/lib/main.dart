import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';

import 'stories/stories.dart';
import 'storybook.dart';

Future<void> main() async {
  runApp(
    Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          theme: DefaultTheme().build(context),
          home: Storybook(
            [
              ButtonStory(), // Supermama
              MenuBarStory(),
              TextStory(),
            ],
          ),
        );
      },
    ),
  );
}
