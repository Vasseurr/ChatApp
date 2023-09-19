// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension DateTimeConverter on String {
  //static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  static DateFormat dateFormatTR = DateFormat("dd-MM-yyyy");
  static DateFormat dateFormatForSaving =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", 'en-US');

  dateToString() {
    return dateFormat.format(dateFormat.parse(DateTime.parse(this).toString()));
  }

  dateToStringTR() {
    return dateFormatTR.format(DateTime(DateTime.parse(this).year,
        DateTime.parse(this).month, DateTime.parse(this).day));
  }

  dateToStringWhenSaving() {
    return DateTime.parse(this).toUtc().toIso8601String().toString();
  }
}

extension NullableStringValidator on String? {
  bool isNotNullOrEmpty() => this != null && this!.isNotEmpty;
}

extension StringExtension on String {
  String toCapitalize() {
    String str = "";
    for (var temp in split(' ')) {
      str += temp[0].toUpperCase() + temp.substring(1).toLowerCase();
    }
    return str;
  }
}
