library repository;

export 'exception/exception.dart';
export 'model/model.dart';

class Repository {
  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();
}
