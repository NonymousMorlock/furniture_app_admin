import 'package:intl/intl.dart';
extension DateExt on DateTime {
  /// Jan 24th, 2021
  String get formattedDate => DateFormat.yMMMMd().format(this);

  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);

  bool get scheduled => isAfter(DateTime.now());
}
