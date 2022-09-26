// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

import 'package:flutter/foundation.dart';

class Keys {
  static _Blocs get Blocs => _Blocs();

  static _Broadcast get Broadcast => _Broadcast();
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

  // Common
  final Key showMessageBloc = const Key('show_message_bloc');
  final Key languageBloc = const Key('language_bloc');

  // Authentication & Authorization
  final Key sessionBloc = const Key('session_bloc');
  final Key signInBloc = const Key('sign_in_bloc');

  // List
  final Key userListBloc = const Key('user_list_bloc');
}

class _Broadcast {
  static final _Broadcast _singleton = _Broadcast._internal();

  factory _Broadcast() {
    return _singleton;
  }

  _Broadcast._internal();

  final String signInSuccess = 'sign_in_success_broadcast';
  final String signOutSuccess = 'sign_out_success_broadcast';
}
