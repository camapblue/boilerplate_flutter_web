part of 'user_details_bloc.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoadInProgress extends UserDetailsState {}

class UserDetailsLoadSuccess extends UserDetailsState {
  final User user;
  const UserDetailsLoadSuccess({required this.user});
}

class UserDetailsLoadFailure extends UserDetailsState {}
