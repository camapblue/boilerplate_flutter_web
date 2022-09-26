import 'package:common/common.dart';
import 'package:repository/client/client.dart';
import 'package:repository/repository.dart';
import 'package:repository/test_data.dart';

class UserClientImpl extends BaseClient implements UserClient {
  UserClientImpl({
    required String host,
    String? authorization,
  }) : super(host, authorization: authorization);

  @override
  Future<User> logIn() async {
    try {
      final json = await post('/users/logIn', {
        'username': 'tester',
        'password': 'abc123',
      });

      return User.fromJson(json['user']);
    } finally {   // mock data
      await Future.delayed(const Duration(seconds: 2));
      return User.test();
    }
  }

  @override
  Future<List<User>> getUsers() async {
    final json = await get('/users');
    final usersJson = List<Map<dynamic, dynamic>>.from(json['users']);
    return usersJson.map((s) {
      try {
        final user = User.fromJson(s);
        return user;
      } catch (e) {
        log.error('Parse user ID = ${s['id']} JSON error: $e');
      }
      throw InvalidInputException('Parse user ID = ${s['id']} JSON');
    }).toList();
  }

  @override
  Future<List<User>> getTestUsers() async {
    await Future.delayed(const Duration(seconds: 3));
    return TestData.getListUsers();
  }
}
