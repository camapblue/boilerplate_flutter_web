library storybook;

import 'package:flutter/material.dart';
import 'dart:ui';
import 'app_navigator.dart';

export 'stateful_story.dart';

/// A Storybook is a widget displaying a collection of [Story] widgets.
///
/// The Storybook is a simple [Scaffold] widget that displays its [Story]
/// widgets in vertical [ListView].
///
/// Storybook.
///
///
///

/// ## Sample code
///
/// ```dart
/// runApp(new StoryboardApp([
///     new MyFancyWidgetStory(),
///     new MyBasicWidgetStory(),
/// ]));
/// ```
class StoryboardApp extends MaterialApp {
  /// Creates a new Storyboard App.
  ///
  ///  * [stories] defines the list of stories that will be combined into
  ///  a storyboard.
  StoryboardApp(List<Story> stories)
      : assert(stories != null, 'stories musst not be null'),
        super(home: Storybook(stories));
}

/// ## Sample code
///
/// ```dart
/// runApp(
///     MaterialApp(
///         home: Storybook([
///             MyFancyWidgetStory(),
///             MyBasicWidgetStory(),
///         ])));
/// ```

class Storybook extends StatefulWidget {
  final _kStoryBookTitle = 'Storybook';
  final List<Story> stories;

  Storybook(this.stories)
      : assert(stories != null, 'stories must not be null'),
        super();

  @override
  State<Storybook> createState() {
    return _StorybookState();
  }
}

class _StorybookState extends State<Storybook> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.amberAccent,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  widget.stories[index],
              itemCount: widget.stories.length,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                color: Colors.black12,
                child: Navigator(
                  key: AppNavigator().navigatorKey,
                  onGenerateRoute: (settings) {
                    _selectedIndex = widget.stories
                        .indexWhere((story) => settings.name == story.title);

                    return MaterialPageRoute(
                      fullscreenDialog: true,
                      settings: settings,
                      builder: widget.stories[_selectedIndex]
                          .storyContent()[0]
                          .builder,
                    );
                  },
                  initialRoute: widget.stories[_selectedIndex].title,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A Story widget is intended as a single "page" of a [Storybook].  It is
/// intended that authors write their own concrete implementations of Stories
/// to include in a [Storybook].
///
/// A story consists of one or more Widgets.  Each Story is rendered as either
/// a [ExpansionTile] or, in the case when there exists only a single
/// fullscreen widget, as [ListTile].
///
/// The story's Widget children are arranged as a series of [Row]s within an
/// ExpansionTile, or if the widget is full screen, is displayed by navigating
/// to a route.
///

typedef StoryBuilder = Widget Function(BuildContext context);

class WidgetMap {
  final String title;
  final StoryBuilder builder;
  const WidgetMap({
    required this.title,
    required this.builder,
  });
}

class StoryScreen extends StatelessWidget {
  final StoryBuilder builder;
  final String title;

  StoryScreen(this.title, this.builder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: builder(context),
    );
  }
}

abstract class Story extends StatelessWidget {
  const Story({Key? key}) : super(key: key);

  List<WidgetMap> storyContent();

  String get title => storyContent()[0].title;

  Widget _widgetTileLauncher(
          StoryBuilder builder, String title, BuildContext context) =>
      ListTile(
        leading: const Icon(Icons.launch),
        title: Text(title),
        onTap: () {
          AppNavigator().navigateTo(title);
        },
      );

  @override
  Widget build(BuildContext context) {
    final List<WidgetMap> _storyContent = storyContent();
    if (_storyContent.length == 1) {
      return _widgetTileLauncher(
          _storyContent[0].builder, _storyContent[0].title, context);
    } else {
      return ExpansionTile(
        leading: const Icon(Icons.fullscreen),
        key: PageStorageKey<Story>(this),
        title: Text(title),
        children: _storyContent
            .map((WidgetMap w) =>
                _widgetTileLauncher(w.builder, w.title, context))
            .toList(),
      );
    }
  }
}
