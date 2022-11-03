class PromodoroTime {
  // 25p = 60 * 25 giay
  static int workingTime =
      DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 25;

  // 5p = 60 * 5 giay
  static int shortBreakTime =
      DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 5;

  // 15p = 60 * 15 giay
  static int longBreakTime =
      DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 15;
}
