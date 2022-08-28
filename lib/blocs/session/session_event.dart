part of 'session_bloc.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class SessionLoaded extends SessionEvent {
  const SessionLoaded();
}

class SessionLoggedOut extends SessionEvent {
  const SessionLoggedOut();
}
