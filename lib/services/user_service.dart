import 'package:repository/repository.dart';

abstract class UserService {
  Future<User> logIn();
}
