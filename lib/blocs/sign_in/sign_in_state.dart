part of 'sign_in_bloc.dart';

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
  const SignInFailure(String message) : super(message: message);
}

class SignInSuccess extends SignInState {
  const SignInSuccess(String message) : super(message: message);
}
