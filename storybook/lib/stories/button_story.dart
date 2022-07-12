import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';

import '../storybook.dart';

// ignore_for_file: avoid_print
class ButtonStory extends Story {
  @override
  List<WidgetMap> storyContent() {
    return [
      WidgetMap(
        title: 'Button',
        builder: (context) => Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Button.pink(
                  title: 'BUTTON: Active',
                  onPressed: () => print('BUTTON: Active - pressed'),
                ),
                const SizedBox(height: 12),
                Button.pink(title: 'BUTTON: Disabled'),
                const SizedBox(height: 12),
                Button.outlinedPink(
                  title: 'BUTTON: Active with Loading indicator',
                  loading: true,
                  onPressed: () =>
                      print('BUTTON: Active with Loading indicator - pressed'),
                ),
                const SizedBox(height: 12),
                Button.outlinedBlue(
                  title: 'OUTLINED BUTTON: Blue',
                  onPressed: () => print('OUTLINED BUTTON: Blue - pressed'),
                ),
                const SizedBox(height: 12),
                Button.outlinedPink(
                  title: 'OUTLINED BUTTON: Pink',
                  onPressed: () => print('OUTLINED BUTTON: Pink - pressed'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Button.outlinedBlue(
                        title: 'Pink',
                        onPressed: () =>
                            print('OUTLINED BUTTON: outlined Blue - pressed'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Button.outlinedPink(
                        title: 'Pink',
                        onPressed: () =>
                            print('OUTLINED BUTTON: outlined Pink - pressed'),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      )
    ];
  }
}
