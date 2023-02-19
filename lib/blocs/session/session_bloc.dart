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
    with ExceptionHandler, Loader {
  final UserService userService;

  SessionBloc(
    Key key, {
    required this.userService,
  }) : super(key, initialState: SessionInitial()) {
    on<SessionLoaded>(_onSessionLoaded);
    on<SessionUserLoggedIn>(_onSessionUserLoggedIn);
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

  @override
  List<Broadcast> subscribes() {
    return [
      Broadcast(
        blocKey: key,
        event: Keys.Broadcast.signInSuccess,
        onNext: (data) {
          final User user = data['user'];

          add(SessionUserLoggedIn(user));
        },
      ),
    ];
  }

  bool get isSignedIn => userService.isLoggedIn;

  void start() {
    if (state is SessionInitial) {
      add(const SessionLoaded());
    }
  }

  Future<void> _onSessionUserLoggedIn(
      SessionUserLoggedIn event, Emitter<SessionState> emit) async {
    emit(
      SessionUserLogInSuccess(
        user: event.loggedInUser,
      ),
    );
  }

  Future<void> _onSessionLoaded(
      SessionLoaded event, Emitter<SessionState> emit) async {
    emit(SessionLoadInProgress());

    try {
      if (!isSignedIn) {
        emit(SessionInitial());
        return;
      } 
      final loggedInUser = await userService.getUserProfile();
      emit(
        SessionUserLogInSuccess(
          user: loggedInUser,
        ),
      );
    } catch (e) {
      if (e is UnauthorisedException) {
        emit(SessionSignOutSuccess());
      } else {
        emit(SessionLoadFailure());
      }
    }
  }

  Future<void> _onSessionLoggedOut(
      SessionLoggedOut event, Emitter<SessionState> emit) async {
    if (!userService.isLoggedIn) {
      return;
    }

    showGlobalLoading();

    try {
      await Future.delayed(const Duration(seconds: 3));
      await userService.logOut();

      emit(SessionSignOutSuccess());
    } on Exception catch (e) {
      handleException(e);
    } finally {
      hideGlobalLoading();
    }
  }
}
