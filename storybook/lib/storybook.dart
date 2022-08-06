library storybook;

import 'package:flutter/material.dart';
// import 'package:antamfoods_admin_app/models/models.dart';
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
/// runApp(
///     MaterialApp(
///         home: Storybook([
///             MyFancyWidgetStory(),
///             MyBasicWidgetStory(),
///         ])));
/// ```

class Storybook extends StatelessWidget {
  const Storybook(this.stories, {Key? key}) : super(key: key);

  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storybook')),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => stories[index],
        itemCount: stories.length,
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
  final String? title;
  final StoryBuilder builder;
  const WidgetMap({this.title, required this.builder});
}

class StoryScreen extends StatelessWidget {
  final StoryBuilder builder;
  final String title;
  final AppBar? appBar;

  const StoryScreen(this.title, this.appBar, this.builder, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ??
          AppBar(
            title: Text(title),
          ),
      body: builder(context),
    );
  }
}

abstract class Story extends StatelessWidget {
  const Story({Key? key}) : super(key: key);

  List<WidgetMap> storyContent();

  String get title => runtimeType.toString();

  AppBar? get appBar => null;

  Widget _widgetTileLauncher(
          StoryBuilder builder, String title, BuildContext context) =>
      ListTile(
        leading: const Icon(Icons.launch),
        title: Text(title),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) {
                return StoryScreen(title, appBar, builder);
              },
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final content = storyContent();
    if (content.length == 1) {
      return _widgetTileLauncher(
          content[0].builder, content[0].title ?? title, context);
    } else {
      return ExpansionTile(
        leading: const Icon(Icons.fullscreen),
        key: PageStorageKey<Story>(this),
        title: Text(title),
        children: content
            .map((WidgetMap w) =>
                _widgetTileLauncher(w.builder, w.title ?? title, context))
            .toList(),
      );
    }
  }
}
