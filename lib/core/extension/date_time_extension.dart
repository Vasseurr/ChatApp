extension DateTimeExtension on DateTime {
  DateTime toNowExceptHourMinuteSeconds() {
    return DateTime(year, month, day);
  }
}
