class ApiException implements Exception {
  final String? _message;
  final String? _prefix;

  ApiException([this._message = 'Api Exception', this._prefix = 'Api']);

  @override
  String toString() {
    return '$_prefix: $_message';
  }

  String get errorMessage => '$_prefix: $_message';
}

class FetchDataException extends ApiException {
  FetchDataException([message = 'Fetch Data Exception'])
      : super(message, 'Fetch Data');
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, 'Invalid');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, 'Unauthorised');
}

class ServerErrorException extends ApiException {
  ServerErrorException([message]) : super(message, 'Server Error');
}

class InvalidInputException extends ApiException {
  InvalidInputException([message]) : super(message, 'Invalid Input');
}

class InvalidResponseException extends ApiException {
  InvalidResponseException([message]) : super(message, 'Invalid Response');
}

class AppException implements Exception {
  final String _message;
  final int _code;

  AppException(Map<String, dynamic> json)
      : _code = json['code'],
        _message = json['msg'];

  @override
  String toString() {
    return '$_code $_message';
  }

  int get errorCode => _code;

  String get errorMessage => _message;
}
