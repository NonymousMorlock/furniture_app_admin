import 'package:intl/intl.dart';
extension DateExt on DateTime {
  /// Jan 24th, 2021
  String get formattedDate => DateFormat.yMMMMd().format(this);
}
