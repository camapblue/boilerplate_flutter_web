import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends BaseBloc<ThemeEvent, ThemeState> {
  ThemeBloc(Key key) : super(key, initialState: const ThemeInitial(null)) {
    on<ThemeLoaded>(_onThemeLoaded);
  }

  factory ThemeBloc.instance() {
    final key = Keys.Blocs.themeBloc;
    return EventBus().newBlocWithConstructor<ThemeBloc>(
      key,
      () => ThemeBloc(key),
    );
  }

  void _onThemeLoaded(ThemeLoaded event, Emitter<ThemeState> emit) {
    emit(
      ThemeLoadSuccess(
        event.theme,
      ),
    );
  }
}
