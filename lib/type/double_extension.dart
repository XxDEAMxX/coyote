import 'package:intl/intl.dart';

class DoubleExtension {
  String toMoneySim(double? number) {
    return '\$${NumberFormat('#,##0', 'es_ES').format(number)}';
  }

  String toMoney(double? number) {
    return NumberFormat('#,##0', 'es_ES').format(number);
  }
}
