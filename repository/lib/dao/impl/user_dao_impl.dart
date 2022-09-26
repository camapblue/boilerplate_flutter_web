import 'package:repository/dao/base_dao.dart';
import 'package:repository/dao/user_dao.dart';
import 'package:repository/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _CurrentUserKey = 'key_current_user';

class UserDaoImpl extends BaseDao<User> implements UserDao {
  UserDaoImpl({required SharedPreferences preferences})
      : super(mapper: Mapper<User>(parser: User.fromJson), prefs: preferences);

  @override
  Future<void> saveUser(User user) {
    return saveItem(user, _CurrentUserKey);
  }

  @override
  User? loadUser() {
    return getItem(_CurrentUserKey);
  }

  @override
  Future<void> clearAuthentication() async {
    await Future.wait([
      clearObjectOrEntity(_CurrentUserKey),
    ]);
  }
}
