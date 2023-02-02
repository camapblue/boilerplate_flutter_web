part of 'session_bloc.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class SessionUserLoggedIn extends SessionEvent {
  final User loggedInUser;

  SessionUserLoggedIn(this.loggedInUser);
}

class SessionLoaded extends SessionEvent {
  const SessionLoaded();
}

class SessionLoggedOut extends SessionEvent {
  const SessionLoggedOut();
}
