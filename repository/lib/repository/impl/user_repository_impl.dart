import 'package:repository/client/client.dart';
import 'package:repository/configs.dart';
import 'package:repository/repository.dart';
import 'package:repository/repository/repository.dart';
import 'package:repository/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserClient userClient;

  UserRepositoryImpl({this.userClient});

  @override
  Future<User> logIn() {
    return userClient.logIn();
  }

  @override
  Future<List<User>> getUsers() {
    return Configs().isDev ? userClient.getTestUsers() : userClient.getUsers();
  }
}
