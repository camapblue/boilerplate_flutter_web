import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';

import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/blocs/blocs.dart';

import 'broadcast.dart';
import 'event_bus.dart';

abstract class BaseBloc<E extends Object, S extends Equatable>
    extends Bloc<E, S> {
  final Key key;
  final Key closeWithBlocKey;

  BaseBloc(this.key, {this.closeWithBlocKey}) : super() {
    otherBlocsSubscription();
  }

  @override
  Future<void> close() async {
    if (closeWithBlocKey != null &&
        closeWithBlocKey != Keys.Blocs.forceToDisposeBloc) {
      return;
    }

    EventBus().unsubscribes(key);
    EventBus().unhandle(key);

    otherBlocsUnsubscription();

    await super.close();
  }

  void otherBlocsSubscription() {}

  void otherBlocsUnsubscription() {}

  List<Broadcast> subscribes() {
    return null;
  }

  void addLater(Object event, {Duration after = const Duration(seconds: 1)}) {
    Future.delayed(after, () {
      add(event);
    });
  }
}
