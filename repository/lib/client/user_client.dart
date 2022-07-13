import 'package:repository/model/user.dart';

abstract class UserClient {
  Future<User> logIn();

  Future<List<User>> getUsers();

  // test data
  Future<List<User>> getTestUsers();
}
