import 'package:easy_localization/easy_localization.dart';

mixin DateTimeMixin {
  DateTime initialDateForCalendar =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  //* for localization
  DateFormat dateFormatEN = DateFormat("yyyy-MM-dd HH:mm");
  DateFormat dateFormatTR = DateFormat("dd-MM-yyyy HH:mm");

  DateTime convertStringToDateTime(String? date) {
    if (date == null) return DateTime.now();
    return DateTime(
        DateTime.parse(date).year,
        DateTime.parse(date).month,
        DateTime.parse(date).day,
        DateTime.parse(date).hour,
        DateTime.parse(date).minute);
  }

  String dateTimeStringValue(String? date) => date != null
      ? dateFormatEN.format(dateFormatEN.parse(DateTime.parse(date).toString()))
      : "";

  String toMessageDate(String? date) {
    if (date == null) return "";
    date = dateTimeStringValue(date);
    DateTime dateTime = convertStringToDateTime(date);
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return "${difference.inDays} day ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    }
    return "a moment ago";
  }
}
