part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  final bool isSignedIn;
  final User? loggedInUser;
  final DateTime updatedDate;

  SessionState(this.isSignedIn, [this.loggedInUser])
      : updatedDate = DateTime.now();

  @override
  List<Object?> get props => [updatedDate];
}

class SessionInitial extends SessionState {
  SessionInitial() : super(false);
}

class SessionLoadSuccess extends SessionState {
  SessionLoadSuccess({
    required bool isSignedIn,
    User? loggedInUser,
  }) : super(isSignedIn, loggedInUser);
}

class SessionLoadFailure extends SessionState {
  SessionLoadFailure() : super(false);
}
