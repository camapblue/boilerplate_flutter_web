// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

class RouteName {
  static const String main = '/';

  static _LogIn get LogIn => _LogIn();

  static _Dashboard get Dashboard => _Dashboard();

  static _Users get Users => _Users();

  static _Settings get Settings => _Settings();

  static _UserDetail get UserDetail => _UserDetail();
}

class _LogIn {
  String get path => '/log-in';
  String get name => 'log-in';
}

class _Dashboard {
  String get path => '/dashboard';
  String get name => 'dashboard';
}

class _Users {
  String get path => '/users';
  String get name => 'users';

  String get fullPath => '${RouteName.Dashboard.path}/users';
}

class _Settings {
  String get path => '/settings';
  String get name => 'settings';

  String get fullPath => '${RouteName.Dashboard.path}/settings';
}

class _UserDetail {
  String get path => '/:userId/detail';
  String get name => 'detail';

  String fullPath(String userId) => '${RouteName.Dashboard.path}/users/$userId/detail';
}