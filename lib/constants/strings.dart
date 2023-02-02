// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

class Strings {
  static _Common get Common => _Common();

  static _Button get Button => _Button();

  static _Navigation get Navigation => _Navigation();

  static _LogIn get LogIn => _LogIn();

  static _Home get Home => _Home();
}

// Common for some test really commonly that can be used in many apps
class _Common {
  final String appName = 'common.app_name';
  final String loading = 'common.loading';
}

class _Button {
  final String logIn = 'button.log_in';
  final String forgotPassword = 'button.forgot_password';
}

class _Navigation {
  final String menuHome = 'navigation.menu.home';
}

class _Home {
  final String noUsers = 'home.no_users';
}

class _LogIn {
  final String welcomeTitle = 'log_in.welcome_title';
  final String welcomeSubtitle = 'log_in.welcome_subtitle';
  final String welcomeDescription = 'log_in.welcome_description';
  final String dontHaveAccount = 'log_in.dont_have_account';
  final String buttonSignUpNow = 'log_in.sign_up_now';
  final String title = 'log_in.title';
  final String subtitle = 'log_in.subtitle';
  final String emailTitle = 'log_in.email_title';
  final String emailPlaceholder = 'log_in.email_placeholder';
  final String passwordTitle = 'log_in.password_title';
  final String passwordPlaceholder = 'log_in.password_placeholder';
  final String buttonForgotPassword = 'log_in.button.forgot_password';
  final String validatorEmailIsRequired = 'log_in.validator.email_is_required';
  final String validatorEmailIsInvalid = 'log_in.validator.email_is_invalid';
  final String validatorPasswordIsInvalid =
      'log_in.validator.password_is_invalid';
  final String errorEmailNotFound = 'log_in.error.email_not_found';
  final String errorWrongPassword = 'log_in.error.email_wrong_password';
}

