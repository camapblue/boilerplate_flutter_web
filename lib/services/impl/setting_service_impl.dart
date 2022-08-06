import 'dart:ui';

import 'package:boilerplate_flutter_web/services/services.dart';

class SettingServiceImpl implements SettingService {
  final List<String> supportedLanguages;
  SettingServiceImpl({required this.supportedLanguages});

  @override
  Locale getCurrentLocale() {
    return Locale(supportedLanguages.first);
  }

  @override
  List<Locale> getSupportedLocales() {
    return supportedLanguages.map(Locale.new).toList();
  }
}
