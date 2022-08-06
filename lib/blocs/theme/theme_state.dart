import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  final dynamic theme;

  const ThemeState([this.theme]);

  @override
  List<Object> get props => [theme];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(dynamic theme) : super(theme);
}

class ThemeLoadSuccess extends ThemeState {
  const ThemeLoadSuccess(dynamic theme) : super(theme);
}
