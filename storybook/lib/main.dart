import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';

import 'stories/stories.dart';
import 'storybook.dart';

Future<void> main() async {
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