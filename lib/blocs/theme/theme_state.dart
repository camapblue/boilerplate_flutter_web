
import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  final dynamic theme;

  ThemeState([ this.theme ]);

  @override
  List<Object> get props => [theme];
}

class ThemeInitial extends ThemeState {
  ThemeInitial(dynamic theme) : super(theme);
}

class ThemeLoadSuccess extends ThemeState {
  ThemeLoadSuccess(dynamic theme) : super(theme);
}