abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeLoaded extends ThemeEvent {
  final dynamic theme;

  const ThemeLoaded([this.theme])
      : assert(theme != null, 'Theme is not null');
}
