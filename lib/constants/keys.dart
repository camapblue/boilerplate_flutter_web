// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

import 'package:flutter/foundation.dart';

class Keys {
  static _Blocs get Blocs => _Blocs();
}

class _Blocs {
  static final _Blocs _singleton = _Blocs._internal();

  factory _Blocs() {
    return _singleton;
  }

  _Blocs._internal();

  // One instance at the given time
  final Key noneDisposeBloc = const Key('none_dispose_bloc');
  final Key forceToDisposeBloc = const Key('force_to_dispose_bloc');
  final Key showMessageBloc = const Key('show_message_bloc');

  final Key themeBloc = const Key('theme_bloc');

  // List
  final Key userListBloc = const Key('user_list_bloc');
}
