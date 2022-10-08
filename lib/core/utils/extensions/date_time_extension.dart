import 'dart:core';

import 'package:intl/intl.dart';

extension DateTimeeExtension on DateTime {
  String toEuFormat() => DateFormat('dd/MM/yyyy').format(this);
  String toEuTimeFormat() => DateFormat('dd/MM/yyyy H:mm').format(this);
  String toEuFormatShortYear() => DateFormat('dd/MM/yy').format(this);
  String toEuFormatNoYear() => DateFormat('dd/MM').format(this);
  String toDateExpiryCardPaiement() => DateFormat('dd/yy').format(this);
  String toTime() => DateFormat('h:mm').format(this);
}
