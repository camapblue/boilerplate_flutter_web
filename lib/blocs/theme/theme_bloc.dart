
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter_web/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter_web/blocs/base/base_bloc.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';

import 'theme.dart';

class ThemeBloc extends BaseBloc<ThemeEvent, ThemeState> {
  ThemeBloc(Key key)
      : super(key, initialState: ThemeInitial(null));

  factory ThemeBloc.instance() {
    return EventBus().newBloc<ThemeBloc>(Keys.Blocs.themeBloc);
  }

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeLoaded) {
      yield ThemeLoadSuccess(event.theme);
    }
  }
}