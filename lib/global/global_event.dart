import 'dart:async';

class GlobalEvent {
  GlobalEvent._privateConstructor();

  static final GlobalEvent instance = GlobalEvent._privateConstructor();

  // ignore: close_sinks
  final onTokenExpired = StreamController<bool>.broadcast();
}
