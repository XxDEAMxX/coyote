import 'package:intl/intl.dart';

class DoubleExtension {
  String toMoney(double? number) {
    return NumberFormat('#,##0', 'es_ES').format(number);
  }
}
