class AuthException implements Exception {
  final String? message;

  AuthException(this.message);
}

class AuthWrongEmailException extends AuthException {
  AuthWrongEmailException(super.message);
}

class AuthWrongPasswordException extends AuthException {
  AuthWrongPasswordException(super.message);
}
