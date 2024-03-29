import 'dart:async';

import 'package:boilerplate_flutter_web/services/exceptions/exceptions.dart';
import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:repository/repository.dart';
import 'package:repository/repository/repository.dart';

class UserServiceImpl implements UserService {
  final UserRepository userRepository;

  UserServiceImpl({
    required this.userRepository,
  });

  @override
  Future<User> logIn({required String email, required String password}) async {
    if (email != 'admin@boilerplate.com') {
      throw AuthWrongEmailException('Wrong email');
    }

    if (password != 'password') {
      throw AuthWrongPasswordException('Wrong password');
    }

    final user = await userRepository.logIn();
    Repository().accessToken = 'access_token_here';

    return user;
  }

  @override
  Future<User> getUserProfile() async {
    return User(
      id: 'id',
      email: 'abc@abc.com',
      name: 'Name',
      role: AdminRole.admin,
    );
  }

  @override
  Future<void> logOut() async {
    await userRepository.clearLoggedInUser();
  }

  @override
  bool get isLoggedIn {
    return userRepository.isSignedIn();
  }

  @override
  Future<User> getUserDetails(String userId) async {
    return User(
      id: userId,
      email: 'abc@abc.com',
      name: 'Name',
      role: AdminRole.employee,
    );
  }
}
