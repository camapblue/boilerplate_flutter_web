import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageBloc extends BaseBloc<LanguageEvent, LanguageState> {
  final SettingService settingService;

  LanguageBloc(Key key, {required this.settingService})
      : super(
          key,
          initialState: LanguageInitial(
            settingService.getCurrentLocale(),
            settingService.getSupportedLocales(),
          ),
        ) {
    on<LanguageUpdated>(_onLanguageUpdated);
  }

  void _onLanguageUpdated(LanguageUpdated event, Emitter<LanguageState> emit) {
    if (event.newLanguage.languageCode == state.locale.languageCode) {
      return;
    }
    emit(
      LanguageUpdateSuccess(event.newLanguage, state.supportedLocales),
    );
  }
}
