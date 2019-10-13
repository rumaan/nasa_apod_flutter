import 'package:intl/intl.dart';

const DATE_FORMAT = "yyyy-MM-dd";

class DateUtils {
  static DateTime getDate(String date) {
    return DateFormat(DATE_FORMAT).parse(date);
  }

  static String getDateString(DateTime date) {
    return DateFormat(DATE_FORMAT).format(date);
  }

  static DateTime format(DateTime date) {
    return DateFormat(DATE_FORMAT).parse(date.toString());
  }
}
