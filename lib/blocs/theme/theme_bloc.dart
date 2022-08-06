import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter_web/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter_web/blocs/base/base_bloc.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';

import 'theme.dart';

class ThemeBloc extends BaseBloc<ThemeEvent, ThemeState> {
  ThemeBloc(Key key) : super(key, initialState: const ThemeInitial(null)) {
    on<ThemeLoaded>(_onThemeLoaded);
  }

  factory ThemeBloc.instance() {
    return EventBus().newBloc<ThemeBloc>(Keys.Blocs.themeBloc);
  }

  void _onThemeLoaded(ThemeLoaded event, Emitter<ThemeState> emit) {
    emit(
      ThemeLoadSuccess(
        event.theme,
      ),
    );
  }
}
