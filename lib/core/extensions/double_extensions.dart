
import 'package:intl/intl.dart';

extension DoubleExt on double {
  String get tableFormat {
    return NumberFormat('#,##0.##')
        .format(this);
  }
}
