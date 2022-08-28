import 'dart:async';

import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/blocs/mixin/mixin.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:common/core/blocs/blocs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends BaseBloc<SessionEvent, SessionState>
    with ExceptionHandler {
  final UserService userService;

  SessionBloc(Key key, {required this.userService})
      : super(key, initialState: SessionInitial()) {
    on<SessionLoaded>(_onSessionLoaded);
    on<SessionLoggedOut>(_onSessionLoggedOut);
  }

  factory SessionBloc.instance() {
    final key = Keys.Blocs.sessionBloc;
    return EventBus().newBlocWithConstructor<SessionBloc>(
      key,
      () => SessionBloc(
        key,
        userService: Provider().userService,
      ),
    );
  }

  bool get isSignedIn => userService.isLoggedIn;

  void start() {
    add(const SessionLoaded());
  }

  Future<void> _onSessionLoaded(
      SessionLoaded event, Emitter<SessionState> emit) async {
    if (!userService.isLoggedIn) {
      emit(SessionLoadSuccess(isSignedIn: false));
    } else {
      try {
        final user = await userService.getUserProfile();

        emit(SessionLoadSuccess(isSignedIn: true, loggedInUser: user));
      } catch (e) {
        unawaited(userService.logOut());
        emit(SessionLoadFailure());
      }
    }
  }

  Future<void> _onSessionLoggedOut(
      SessionLoggedOut event, Emitter<SessionState> emit) async {
    if (!userService.isLoggedIn) {
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 2));
      await userService.logOut();
      emit(SessionInitial());
    } on Exception catch (e) {
      handleException(e);
    }
  }
}
