import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:repository/model/model.dart';
import 'package:repository/repository/repository.dart';

class UserListServiceImpl implements UserListService {
  final UserRepository userRepository;
  const UserListServiceImpl({required this.userRepository});

  @override
  Future<List<User>> loadItems({Map<String, dynamic> params = const {}}) async {
    return userRepository.getUsers();
  }

  @override
  Future<void> shouldRefreshItems(
      {Map<String, dynamic> params = const {}}) async {}

  @override
  bool shouldReloadData({Map<String, dynamic> params = const {}}) {
    return true;
  }
}
