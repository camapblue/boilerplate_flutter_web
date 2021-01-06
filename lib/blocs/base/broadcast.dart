import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

typedef BroadcastObserver = void Function(Map data);

class Broadcast extends Equatable {
  final Key blocKey;
  final String event;
  final BroadcastObserver onNext;

  Broadcast({this.blocKey, this.event, this.onNext});

  @override
  List<Object> get props => [blocKey];
}