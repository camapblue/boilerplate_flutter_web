import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/blocs/mixin/mixin.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/services/exceptions/exceptions.dart';
import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends BaseBloc<SignInEvent, SignInState>
    with ExceptionHandler {
  final UserService userService;

  SignInBloc(Key key, {required this.userService})
      : super(key, initialState: SignInInitial()) {
    on<SignInFormSubmitted>(_onSignInFormSubmitted);
    on<SignedOut>(_onSignOut);
  }

  factory SignInBloc.instance() {
    final key = Keys.Blocs.signInBloc;
    return EventBus().newBlocWithConstructor<SignInBloc>(
      key,
      () => SignInBloc(
        key,
        userService: Provider().userService,
      ),
    );
  }

  @override
  List<Broadcast> subscribes() {
    return <Broadcast>[
      Broadcast(
        blocKey: Keys.Blocs.signInBloc,
        event: Keys.Broadcast.signOutSuccess,
        onNext: (_) {
          add(SignedOut());
        },
      ),
    ];
  }

  Future<void> _onSignInFormSubmitted(
      SignInFormSubmitted event, Emitter<SignInState> emit) async {
    emit(const SignInRequestInProgress());
    try {
      await Future.delayed(const Duration(seconds: 3));

      final user =
          await userService.logIn(email: event.email, password: event.password);

      EventBus().broadcast(
        Keys.Broadcast.signInSuccess,
        params: {'user': user},
      );

      emit(const SignInSuccess('Sign In Successfully!'));
    } catch (e) {
      if (e is AuthWrongEmailException) {
        emit(const SignInFailure(error: SignInError.wrongEmail));
      } else if (e is AuthWrongPasswordException) {
        emit(const SignInFailure(error: SignInError.wrongPassword));
      } else if (e is UnauthorisedException) {
        emit(const SignInFailure(error: SignInError.notFoundUserByEmail));
      } else {
        handleException(e as Exception);
        emit(const SignInFailure());
      }
    }
  }

  Future<void> _onSignOut(SignedOut event, Emitter<SignInState> emit) async {
    emit(SignInInitial());
  }
}
