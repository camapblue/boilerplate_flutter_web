part of 'sign_in_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class SignInFormSubmitted extends SignInEvent {
  final String email;
  final String password;

  const SignInFormSubmitted({
    required this.email,
    required this.password,
  });
}

class SignedOut extends SignInEvent {}
