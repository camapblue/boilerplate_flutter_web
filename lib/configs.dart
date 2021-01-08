import 'dart:convert';

import 'package:common/common.dart';

class Configs {
  static final Configs _singleton = Configs._internal();

  factory Configs() {
    if (_singleton._configs == null) {
      try {
        final env =
            const String.fromEnvironment('env').replaceAll('\\"', '\"');
        _singleton._configs =
            json.decode(env.substring(0, env.length - 1).substring(1));
      } catch (e) {
        log.error('Error >> $e');
        _singleton._configs = {};
      }

      
    }
    return _singleton;
  }

  Configs._internal();
  dynamic _configs;

  String get baseURL => _configs['BASE_URL'] ?? 'https://default.com/';
}
