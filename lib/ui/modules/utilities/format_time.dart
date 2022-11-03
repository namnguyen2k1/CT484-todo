String formatTimeLocalArea({
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
