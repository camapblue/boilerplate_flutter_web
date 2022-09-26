library repository;

import 'package:repository/client/client.dart';
import 'package:repository/configs.dart';
import 'package:repository/dao/dao.dart';
import 'package:repository/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'exception/exception.dart';
export 'model/model.dart';
export 'enum/enum.dart';

class Repository {
  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String? accessToken;
  late SharedPreferences _sharedPreferences;

  // Repository
  UserRepository get userRepository => UserRepositoryImpl(
        userClient: userClient,
        userDao: userDao,
      );

  // Client
  UserClient get userClient => UserClientImpl(
        host: Configs().baseURL,
        authorization: accessToken,
      );

  // Dao
  UserDao get userDao => UserDaoImpl(preferences: _sharedPreferences);
}
