import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String toDateTimeString(DateTime dateTime,
      {String format = "d MMMM y hh:mm a"}) {
    try {
      return DateFormat(format).format(dateTime.toLocal());
    } catch (e) {
      return '';
    }
  }
}
