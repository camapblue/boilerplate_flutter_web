import 'package:qlevar_router/qlevar_router.dart';

class AppNavigator {
  static final AppNavigator _singleton = AppNavigator._internal();

  factory AppNavigator() {
    return _singleton;
  }

  AppNavigator._internal();

  Future<void> go(String path) {
    final currentPath = QR.currentPath;
    return QR.navigator.replace(currentPath, path);
  }

  Future<void> back() {
    return QR.back();
  }

  Future<void> goWithName(String name, {Map<String, dynamic>? params}) {
    return QR.navigator.replaceLastName(name, params: params);
  }

  String get location => QR.currentPath;
}
