part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class UserDetailsLoaded extends UserDetailsEvent {
  final String userId;
  const UserDetailsLoaded({required this.userId});
}

class UserDetailsSet extends UserDetailsEvent {
  final User user;
  const UserDetailsSet({required this.user});
}
