import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';
import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/services/services.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc
    extends BaseBloc<UserDetailsEvent, UserDetailsState> {
  final UserService _userService;

  UserDetailsBloc(
    Key key, {
    required UserService userService,
  })  : _userService = userService,
        super(key, initialState: UserDetailsInitial()) {
    on<UserDetailsLoaded>(_onUserDetailsLoaded);
    on<UserDetailsSet>(_onUserDetailsSet);
  }

  factory UserDetailsBloc.instance(String userId) {
    final key = Keys.Blocs.userDetailBloc(userId);

    return EventBus().newBlocWithConstructor(
      key,
      () => UserDetailsBloc(key, userService: Provider().userService),
    );
  }

  Future<void> _onUserDetailsLoaded(
    UserDetailsLoaded event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(UserDetailsLoadInProgress());
    try {
      final user = await _userService.getUserDetails(event.userId);

      EventBus().broadcast(
        Keys.Broadcast.userDetailsUpdated,
        params: {'user': user},
      );

      emit(UserDetailsLoadSuccess(user: user));
    } catch (e) {
      emit(UserDetailsLoadFailure());
    }
  }

  void _onUserDetailsSet(
    UserDetailsSet event,
    Emitter<UserDetailsState> emit,
  ) {
    emit(UserDetailsLoadSuccess(user: event.user));
  }
}
