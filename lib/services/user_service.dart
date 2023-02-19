import 'package:repository/repository.dart';

abstract class UserService {
  Future<User> logIn({required String email, required String password});

  Future<User> getUserProfile();

  Future<void> logOut();

  bool get isLoggedIn;

  Future<User> getUserDetails(String userId);
}
