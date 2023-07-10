
import 'package:intl/intl.dart';

extension DoubleExt on double {
  String get tableFormat {
    return NumberFormat('#,##0.##')
        .format(this);
  }

  String get currencyFormat => NumberFormat.currency(
    name: 'GHS',
    symbol: '₵',
    decimalDigits: 2,
  ).format(this);
}
