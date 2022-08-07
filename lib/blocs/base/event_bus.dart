import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:common/common.dart';

import '../blocs.dart';

class RetryEvent {
  final Key key;
  final Object event;

  RetryEvent({required this.key, required this.event});
}

class EventBus {
  static final EventBus _singleton = EventBus._internal();

  factory EventBus() {
    return _singleton;
  }

  Map<Key, BaseBloc> _blocs = {};
  List<Broadcast> _broadcasts = [];

  Map<Key, RetryEvent> _retryEvents = {};

  EventBus._internal() {
    _blocs = {};
    _broadcasts = [];
    _retryEvents = {};
  }

  T newBloc<T extends BaseBloc>(Key key) {
    final found = _blocs[key];
    if (found != null && found is T) {
      return found;
    }

    try {
      final T newInstance = blocConstructors[T]!(key) as T;
      log.trace('New Bloc is created with key = $key');
      _blocs[key] = newInstance;
      if (newInstance.subscribes().isNotEmpty) {
        _broadcasts.addAll(newInstance.subscribes());
      }
      _retryEvent<T>(key);
      return newInstance;
    } catch (e) {
      log.error('Error in new instance of bloc $key: $e');
    }
    throw Exception('Something went wrong in creating bloc $T');
  }

  T newBlocWithConstructor<T extends BaseBloc>(Key key, Function constructor) {
    final found = _blocs[key];
    if (found != null && found is T) {
      return found;
    }

    try {
      final T newInstance = constructor();
      log.trace('New Bloc is created with key = $key');
      _blocs[key] = newInstance;
      if (newInstance.subscribes().isNotEmpty) {
        _broadcasts.addAll(newInstance.subscribes());
      }
      _retryEvent<T>(key);
      return newInstance;
    } catch (e) {
      log.error('Error in new instance of bloc $key: $e');
    }
    throw Exception('Something went wrong in creating bloc with key $key');
  }

  T? blocFromKey<T extends BaseBloc>(Key key) {
    final found = _blocs[key];
    if (found != null && found is T) {
      return found;
    } else {
      log.error('Cannot found bloc with key $key');
    }
    return null;
  }

  void event<T extends BaseBloc>(Key key, Object event,
      {bool retryLater = false, Duration? delay}) {
    try {
      final found = _blocs[key];
      if (found != null && found is T) {
        if (delay != null) {
          Future.delayed(delay, () {
            found.add(event);
          });
        } else {
          found.add(event);
        }
      } else {
        log.error('Cannot found bloc with key $key for event $event');
        if (retryLater) {
          _retryEvents[key] = RetryEvent(key: key, event: event);
        }
      }
    } catch (e) {
      log.error('Call bloc event error: $e');
    }
  }

  void broadcast(String event, {Map params = const {}}) {
    for (final b in _broadcasts) {
      if (b.event == event) {
        b.onNext(params);
      }
    }
  }

  void unsubscribes(Key blocKey) {
    _broadcasts.removeWhere((b) {
      return b.blocKey == blocKey;
    });
  }

  void unhandle(Key blocKey) {
    _blocs.removeWhere((key, bloc) {
      return key == blocKey || bloc.closeWithBlocKey == blocKey;
    });
  }

  void _retryEvent<T extends BaseBloc>(Key key) {
    final found = _retryEvents[key];
    if (found != null) {
      event<T>(key, found.event);
      _retryEvents.remove(key);
    }
  }

  // support methods
  void cleanUp({Key? parentKey}) {
    final removedKeys = <Key>[];
    final closeKey = parentKey ?? Keys.Blocs.noneDisposeBloc;
    _blocs.removeWhere((key, bloc) {
      if (bloc.closeWithBlocKey == closeKey) {
        removedKeys.add(key);
        return true;
      }
      return false;
    });

    _broadcasts.removeWhere((b) {
      return removedKeys.contains(b.blocKey);
    });
  }
}
