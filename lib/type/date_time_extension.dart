import 'package:intl/intl.dart';

class DateTimeExtension {
  String toHumanize(DateTime? date) {
    if (date == null) {
      return '-';
    }
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
