import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'language_bloc_test.mocks.dart';

@GenerateMocks([SettingService])
void main() {
  LanguageBloc? languageBloc;
  final SettingService settingService = MockSettingService();

  const currentLocale = Locale('fr');
  const supportedLocales = [Locale('fr'), Locale('en')];

  setUp(() {
    when(settingService.getCurrentLocale()).thenReturn(currentLocale);
    when(settingService.getSupportedLocales()).thenReturn(supportedLocales);

    languageBloc = LanguageBloc(
      const Key('language_bloc'),
      settingService: settingService,
    );
  });

  tearDownAll(() {
    languageBloc?.close();
  });

  group('LanguageInitial', () {
    test('LanguageInitial is set current locale & supported locales', () {
      const state = LanguageInitial(currentLocale, supportedLocales);

      expect(languageBloc!.state, state);
    });
  });

  group('LanguageLoaded', () {
    blocTest(
      '''
        emits [LanguageUpdateSuccess] when LanguageUpdated(en) is added
      ''',
      build: () => languageBloc!,
      act: (bloc) =>
          (bloc as LanguageBloc).add(const LanguageUpdated(Locale('en'))),
      expect: () => [isA<LanguageUpdateSuccess>()],
    );
  });
}
