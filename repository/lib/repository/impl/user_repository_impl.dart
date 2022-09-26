import 'package:repository/client/client.dart';
import 'package:repository/configs.dart';
import 'package:repository/dao/dao.dart';
import 'package:repository/repository.dart';
import 'package:repository/repository/repository.dart';
import 'package:repository/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserClient userClient;
  final UserDao userDao;

  UserRepositoryImpl({
    required this.userClient,
    required this.userDao,
  });

  @override
  Future<User> logIn() async {
    final user = await userClient.logIn();

    await userDao.saveUser(user);
    return user;
  }

  @override
  Future<List<User>> getUsers() {
    return Configs().isDev ? userClient.getTestUsers() : userClient.getUsers();
  }

  @override
  bool isSignedIn() {
    final currentUser = userDao.loadUser();
    return currentUser != null;
  }

  @override
  Future<void> clearLoggedInUser() async {
    await userDao.clearAuthentication();
  }
}
