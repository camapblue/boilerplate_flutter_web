part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  final User? loggedInUser;
  final DateTime updatedDate;

  SessionState([this.loggedInUser]) : updatedDate = DateTime.now();

  @override
  List<Object?> get props => [updatedDate];
}

class SessionInitial extends SessionState {
  SessionInitial() : super();
}

class SessionLoadInProgress extends SessionState {
  SessionLoadInProgress() : super();
}

class SessionUserLogInSuccess extends SessionState {
  SessionUserLogInSuccess({
    required User user,
  }) : super(
          user,
        );
}

class SessionLoadFailure extends SessionState {
  SessionLoadFailure() : super();
}

class SessionSignOutSuccess extends SessionState {
  SessionSignOutSuccess() : super();
}

