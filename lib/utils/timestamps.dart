import 'package:intl/intl.dart';

final formatter = DateFormat('dd.MM.yyyy HH:mm:ss');

String gmtStamp(DateTime dt) {
  final offset = dt.timeZoneOffset;
  final sign = offset.isNegative ? '' : '+';
  final hours = offset.inHours.toString().padLeft(2, '0');
  final minutes =
      (offset.inMinutes - (offset.inHours * 60)).toString().padLeft(2, '0');
  return 'GMT$sign$hours:$minutes';
}
