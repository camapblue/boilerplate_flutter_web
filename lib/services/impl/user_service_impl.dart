import 'dart:async';

import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:repository/repository/repository.dart';

class UserServiceImpl implements UserService {
  final UserRepository userRepository;

  UserServiceImpl({
    @required this.userRepository,
  });

  @override
  Future<User> logIn() async {
    final user = await userRepository.logIn();
    Repository().accessToken = 'access_token_here';

    return user;
  }
}