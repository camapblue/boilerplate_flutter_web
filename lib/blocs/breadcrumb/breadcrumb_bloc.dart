import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_flutter_web/blocs/blocs.dart';
import 'package:boilerplate_flutter_web/models/models.dart';

part 'breadcrumb_state.dart';
part 'breadcrumb_event.dart';

class BreadcrumbBloc extends BaseBloc<BreadcrumbEvent, BreadcrumbState> {
  BreadcrumbBloc(
    Key key, {
    required BreadcrumbPage initialPage,
  }) : super(key, initialState: BreadcrumbInitial([initialPage])) {
    on<BreadcrumbNavigatedTo>(_onBreadcrumbNavigatedTo);
    on<BreadcrumbSet>(_onBreadcrumbSet);
  }

  factory BreadcrumbBloc.instance({required BreadcrumbPage root}) {
    final key = Keys.Blocs.breadcrumbBloc;
    return EventBus().newBlocWithConstructor<BreadcrumbBloc>(
      key,
      () => BreadcrumbBloc(key, initialPage: root),
    );
  }

  void _onBreadcrumbNavigatedTo(
      BreadcrumbNavigatedTo event, Emitter<BreadcrumbState> emit) {
    final totalPage = state.pages.length;
    final pages = List<BreadcrumbPage>.from(state.pages)
      ..removeRange(event.index + 1, totalPage);

    emit(BreadcrumbNavigateSuccess(pages));
  }

  void _onBreadcrumbSet(BreadcrumbSet event, Emitter<BreadcrumbState> emit) {
    emit(BreadcrumbInitial(event.pages));
  }

  String get path {
    return state.pages.map((e) => e.linkTo).toList().join(' >> ');
  }
}
