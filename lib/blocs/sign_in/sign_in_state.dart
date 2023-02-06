part of 'sign_in_bloc.dart';

enum SignInError { wrongEmail, wrongPassword, notFoundUserByEmail, unknown }

abstract class SignInState extends Equatable {
  final String? message;

  const SignInState({this.message});
  @override
  List<Object?> get props => [
        message,
      ];
}

class SignInInitial extends SignInState {}

class SignInRequestInProgress extends SignInState {
  const SignInRequestInProgress() : super();
}

class SignInFailure extends SignInState {
  final SignInError error;

  const SignInFailure({this.error = SignInError.unknown});
}

class SignInSuccess extends SignInState {
  const SignInSuccess(String message) : super(message: message);
}
