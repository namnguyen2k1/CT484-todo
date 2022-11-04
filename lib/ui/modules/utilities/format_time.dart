class FormatTime {
  static String formatTimeLocalArea({
    required DateTime time,
    String prefix = '/',
    area = 'vi',
  }) {
    final String day = time.day.toString();
    final String month = time.month.toString();
    final String year = time.year.toString();
    if (area == 'vi') {
      return '$day$prefix$month$prefix$year';
    } else if (area == 'eng') {
      return '$month$prefix$day$prefix$year';
    }

    return '__${prefix}__${prefix}__';
  }

  static String convertTimestampToFormatTimer(String timeStamp,
      {String prefix = '/'}) {
    final timeMap = DateTime.parse(timeStamp);
    // final int h = timeMap.hour;
    // final int m = timeMap.minute;
    // final int s = timeMap.second;
    final int day = timeMap.day;
    final int month = timeMap.month;
    final int year = timeMap.year;
    // String createdTime = '';
    // createdTime = '$createdTime${h.toString().padLeft(2, '0')}:';
    // createdTime = '$createdTime${m.toString().padLeft(2, '0')}:';
    // createdTime = createdTime + s.toString().padLeft(2, '0');
    // if (h >= 12) {
    //   createdTime = '$createdTime PM';
    // }
    // createdTime = '$createdTime AM';
    String createdDay = '$day$prefix$month$prefix$year';
    return createdDay;
  }

  static String converSecondsToText(int seconds) {
    final h = (seconds / 3600).floor();
    final m = ((seconds / 60) % 60).floor();
    final s = (seconds % 60).floor();
    String result = '';
    if (h != 0) result = '$result${h}h';
    if (m != 0) result = '$result${m}m';
    if (s != 0) result = '$result${s}s';
    return result;
  }

  static int converTimestampToSecond(String timestamp) {
    final timeMap = DateTime.parse(timestamp);
    final int h = timeMap.hour;
    final int m = timeMap.minute;
    final int s = timeMap.second;
    return h * 3600 + m * 60 + s;
  }
}
