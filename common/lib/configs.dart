import 'dart:convert';

class Configs {
  static final Configs _singleton = Configs._internal();

  factory Configs() {
    if (_singleton._configs == null) {
      try {
        String env =
            const String.fromEnvironment('env').replaceAll('\\"', '\"');
        _singleton._configs =
            json.decode(env.substring(0, env.length - 1).substring(1));
      } catch (e) {
        print('Error >> $e');
        _singleton._configs = {};
      }
    }
    return _singleton;
  }

  Configs._internal();
  dynamic _configs;

  String get logLevel => _configs['LOG_LEVEL'] ?? 'error';
}
