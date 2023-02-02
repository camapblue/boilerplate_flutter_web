import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AppRouting {
  static final AppRouting _singleton = AppRouting._internal();

  factory AppRouting() {
    return _singleton;
  }

  AppRouting._internal()
      : _dashboardContentKey = LabeledGlobalKey('dashboard_content_key');

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  NavigatorState? get navigator => _navigatorKey.currentState;

  String get currentPath => QR.currentPath;

  GlobalKey _dashboardContentKey;

  GlobalKey dashboardContentKeyForRender() {
    // ignore: join_return_with_assignment
    _dashboardContentKey =
        LabeledGlobalKey('''dashboard_content_key_${DateTime.now()}''');

    return _dashboardContentKey;
  }

  GlobalKey get dashboardContentKey => _dashboardContentKey;

  void goToName(String routeName, {Map<String, dynamic>? params}) {
    QR.toName(routeName, params: params);
  }

  void popUntil(String routeName) {
    QR.navigator.popUntilOrPush(routeName);
  }

  void pushReplacementNamed(String routeName, {Map<String, dynamic>? params}) {
    QR.navigator.replaceAllWithName(routeName, params: params);
  }

  Future<void> go(String path) {
    final currentPath = QR.currentPath;
    return QR.navigator.replace(currentPath, path);
  }

  Future<void> goWithHiddenParams(
    String path, {
    Map<String, dynamic>? params,
    bool includesCurrentParams = false,
    bool includesHiddenParams = false,
  }) {
    final currentPath = QR.currentPath;
    if (params != null) {
      for (final item in params.entries) {
        QR.params.addAsHidden(item.key, item.value, cleanUpAfter: 3);
      }
    }
    if (includesCurrentParams) {
      final query = Uri.dataFromString(currentPath).queryParameters;
      for (final item in query.entries) {
        QR.params.addAsHidden(item.key, item.value, cleanUpAfter: 3);
      }
    }
    if (includesHiddenParams) {
      final params = QR.params.asValueMap;
      for (final item in params.entries) {
        QR.params.addAsHidden(item.key, item.value, cleanUpAfter: 3);
      }
    }
    return QR.navigator.replace(currentPath, path);
  }

  Future<void> goWithName(String name, {Map<String, dynamic>? params}) {
    return QR.navigator.replaceLastName(name, params: params);
  }

  String get location => QR.currentPath;

  void goBack() {
    QR.back();
  }
}
