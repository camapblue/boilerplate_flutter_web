import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/global/global.dart';
import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends BaseBloc<SignInEvent, SignInState> {
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
      await userService.logIn();
      emit(const SignInSuccess('Sign In Successfully!'));

      EventBus().broadcast(Keys.Broadcast.signInSuccess);
    } catch (e) {
      emit(const SignInFailure('Invalid email or password. Please try again.'));
    }
  }

  Future<void> _onSignOut(SignedOut event, Emitter<SignInState> emit) async {
    emit(SignInInitial());
  }
}
