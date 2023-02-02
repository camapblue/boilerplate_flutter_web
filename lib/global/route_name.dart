// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

class RouteName {
  static const String main = '/';

  static _LogIn get LogIn => _LogIn();

  static _Dashboard get Dashboard => _Dashboard();

}

class _LogIn {
  String get path => '/log-in';
  String get name => 'log-in';
}

class _Dashboard {
  String get path => '/dashboard';
  String get name => 'dashboard';
}
