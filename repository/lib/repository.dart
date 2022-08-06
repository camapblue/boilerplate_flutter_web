library repository;

import 'package:repository/client/client.dart';
import 'package:repository/configs.dart';
import 'package:repository/repository/repository.dart';

export 'exception/exception.dart';
export 'model/model.dart';
export 'enum/enum.dart';

class Repository {
  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();

  String? accessToken;

  // Repository
  UserRepository get userRepository => UserRepositoryImpl(
        userClient: userClient,
      );

  // Client
  UserClient get userClient => UserClientImpl(
        host: Configs().baseURL,
        authorization: accessToken,
      );
}
