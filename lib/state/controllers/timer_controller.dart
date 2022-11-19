import 'package:flutter/foundation.dart';

import '../../ui/modules/timer/time_left_notifier.dart';

enum ButtonState { initial, started, paused, finished }

class TimerController extends ChangeNotifier {
  final timeLeftNotifier = TimeLeftNotifier();
  final buttonStateNotifier = ValueNotifier<ButtonState>(ButtonState.initial);

  void initialize(int seconds) {
    timeLeftNotifier.initialize(seconds);
  }

  void start() {
    if (buttonStateNotifier.value == ButtonState.paused) {
      _unpauseTimer();
    } else {
      _startTimer();
    }
  }

  void _unpauseTimer() {
    buttonStateNotifier.value = ButtonState.started;
    timeLeftNotifier.unpause();
  }

  void _startTimer() {
    buttonStateNotifier.value = ButtonState.started;
    timeLeftNotifier.start(onDone: () {
      buttonStateNotifier.value = ButtonState.finished;
    });
  }

  void pause() {
    timeLeftNotifier.pause();
    buttonStateNotifier.value = ButtonState.paused;
  }

  void reset() {
    timeLeftNotifier.reset();
    buttonStateNotifier.value = ButtonState.initial;
  }

  void dispose() {
    timeLeftNotifier.dispose();
  }
}
