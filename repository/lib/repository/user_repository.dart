import 'package:repository/model/model.dart';

abstract class UserRepository {
  Future<User> logIn();

  Future<List<User>> getUsers();

  bool isSignedIn();

  Future<void> clearLoggedInUser();
}
