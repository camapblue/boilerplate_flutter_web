import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMessageBloc extends BaseBloc<ShowMessageEvent, ShowMessageState> {
  ShowMessageBloc(Key key) : super(key, initialState: ShowMessageInitial()) {
    on<WarningMessageShowed>(_onWarningMessageShowed);
    on<ErrorMessageShowed>(_onErrorMessageShowed);
  }

  factory ShowMessageBloc.instance() {
    return EventBus().newBloc<ShowMessageBloc>(Keys.Blocs.showMessageBloc);
  }

  void _onWarningMessageShowed(
      WarningMessageShowed event, Emitter<ShowMessageState> emit) {
    emit(
      ShowWarningMessageSuccess(
        event.messageKey,
        params: event.params,
        isSuccess: event.isSuccess,
      ),
    );
  }

  void _onErrorMessageShowed(
      ErrorMessageShowed event, Emitter<ShowMessageState> emit) {
    emit(ShowErrorMessageSuccess(event.messageKey, params: event.params));
  }
}
