import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_bloc.dart';
import 'broadcast.dart';

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

  List<RetryEvent> _retryEvents = [];

  EventBus._internal() {
    _blocs = {};
    _broadcasts = [];
    _retryEvents = [];
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
        if (retryLater) {
          _retryEvents.add(RetryEvent(key: key, event: event));
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
    for (final b in _blocs.entries) {
      if (b.key == blocKey || b.value.closeWithBlocKey == blocKey) {
        _blocs.remove(blocKey);
      }
    }
  }

  void _retryEvent<T extends BaseBloc>(Key key) {
    for (var i = 0; i < _retryEvents.length; i++) {
      final retry = _retryEvents[i];
      if (retry.key == key) {
        event<T>(retry.key, retry.event);
        _retryEvents.removeAt(i);
        break;
      }
    }
  }

  // support methods
  void cleanUp({Key? parentKey}) {
    final removedKeys = <Key>[];
    final closeKey = parentKey ?? const ValueKey('none_dispose_bloc');
    for (final b in _blocs.entries) {
      if (b.value.closeWithBlocKey == closeKey) {
        removedKeys.add(b.key);
        _blocs.remove(closeKey);
      }
    }
    
    _broadcasts.removeWhere((b) {
      return removedKeys.contains(b.blocKey);
    });
  }
}
