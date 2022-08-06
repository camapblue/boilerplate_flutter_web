// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/configs.dart';
import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class Provider {
  static final Provider _singleton = Provider._internal();

  factory Provider() {
    return _singleton;
  }

  Provider._internal();

  _BlocProvider get BlocProvider => _BlocProvider();

  // Service
  UserService get userService => UserServiceImpl(
        userRepository: Repository().userRepository,
      );

  UserListService get userListService => UserListServiceImpl(
        userRepository: Repository().userRepository,
      );

  SettingService get settingService => SettingServiceImpl(
        supportedLanguages: Configs().supportedLanguages,
      );
}

// Common for some test really commonly that can be used in many apps
class _BlocProvider {
  BlocProvider<LoadListBloc<User>> userList(Key key) {
    return BlocProvider<LoadListBloc<User>>(
      create: (_) => EventBus().newBlocWithConstructor(
        key,
        () => LoadListBloc<User>(
          key,
          loadListService: Provider().userListService,
        ),
      ),
    );
  }
}
