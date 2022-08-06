// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

class Strings {
  static _Common get Common => _Common();

  static _Navigation get Navigation => _Navigation();

  static _Home get Home => _Home();
}

// Common for some test really commonly that can be used in many apps
class _Common {
  final String appName = 'common.app_name';
  final String loading = 'common.loading';
}

class _Navigation {
  final String menuHome = 'navigation.menu.home';
}

class _Home {
  final String noUsers = 'home.no_users';
}
