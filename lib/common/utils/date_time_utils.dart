class DateTimeUtils {
  static DateTime reminderTime() {
    final now = DateTime.now();
    final today11AM = DateTime.now().copyWith(
      hour: 11,
      minute: 0,
      second: 0,
    );

    var resultTomorrow = today11AM.add(const Duration(days: 1));

    return now.isAfter(today11AM) ? resultTomorrow : today11AM;
  }
}
