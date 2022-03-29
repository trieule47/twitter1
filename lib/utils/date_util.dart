import 'package:intl/intl.dart';

class DateUtil {
  static final String formatDate = 'DD/MM/YYYY';
  static final String formatDateSql = 'YYYY-MM-DD';
  static final String formatDateTimeZone = 'YYYY-MM-DD HH:mm:ss.SSSZZZ';
  static final String formatTime = 'HH:mm';
  static final String formatTimeSecond = 'HH:mm:ss';
  static final String formatDateTime = 'DD/MM/YYYY HH:mm:ss';
  static final String formatDateTimeSql = 'YYYY-MM-DD hh:mm:ss';

  /// Get time now
  static DateTime now() {
    return DateTime.now();
  }

  /// Parse now with [format]
  static String parseNow(String format) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat(format);
    return formatter.format(now);
  }

  /// Compare date with [value1] and [value2]
  static int compareDate(String value1, String value2, String format) {
    DateFormat formatter = DateFormat(format);
    DateTime date1 = formatter.parse(value1);
    DateTime date2 = formatter.parse(value2);
    if (date1.isAfter(date2)) {
      return 1;
    } else if (date1.isBefore(date2)) {
      return -1;
    }
    return 0;
  }

  /// Convert date from format to format
  static String convertFromFormatToFormat(date, fromFormat, toFormat) {
    DateFormat fromFormatter = DateFormat(fromFormat);
    DateFormat toFormatter = DateFormat(toFormat);
    DateTime dateTime = fromFormatter.parse(date);
    return toFormatter.format(dateTime);
  }

}
