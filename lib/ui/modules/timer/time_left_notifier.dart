import 'dart:async';
import 'package:flutter/foundation.dart';

class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}

class TimeLeftNotifier extends ValueNotifier<String> {
  TimeLeftNotifier() : super(_timeLeftString(0));
  // 00:00

  final _ticker = const Ticker();
  StreamSubscription<int>? _tickerSubscription;

  late int _initialValue;
  int _currentTimeLeft = 0;

  static String _timeLeftString(int seconds) {
    final hour = (seconds / 3600).floor().toString().padLeft(2, '0');
    final min = ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    final sec = (seconds % 60).floor().toString().padLeft(2, '0');
    return '$hour:$min:$sec';
  }

  void _updateTimeLeft(int seconds) {
    value = _timeLeftString(seconds);
    _currentTimeLeft = seconds;
  }

  void initialize(int seconds) {
    _initialValue = seconds;
    _updateTimeLeft(seconds);
  }

  void start({required Function onDone}) {
    _tickerSubscription?.cancel();

    _tickerSubscription = _ticker
        .tick(ticks: _currentTimeLeft)
        .listen((seconds) => _updateTimeLeft(seconds));

    _tickerSubscription?.onDone(() => onDone());
  }

  void pause() {
    _tickerSubscription?.pause();
  }

  void unpause() {
    _tickerSubscription?.resume();
  }

  void reset() {
    _tickerSubscription?.cancel();
    _updateTimeLeft(_initialValue);
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}
