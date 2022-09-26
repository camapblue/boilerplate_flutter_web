import 'package:repository/model/model.dart';

abstract class UserDao {
  Future<void> saveUser(User user);

  User? loadUser();

  Future<void> clearAuthentication();
}
