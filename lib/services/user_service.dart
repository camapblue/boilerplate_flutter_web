import 'package:repository/repository.dart';

abstract class UserService {
  Future<User> logIn();

  Future<User> getUserProfile();

  Future<void> logOut();

  bool get isLoggedIn;
}
