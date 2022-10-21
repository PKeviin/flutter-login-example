import 'package:intl/intl.dart';

extension NumberExtensions on num {
  /// Formats a number with thousand and comma separator
  String formatCurrency({
    int decimal = 2,
    bool showSign = true,
  }) =>
      NumberFormat.currency(
        locale: Intl.getCurrentLocale(),
        decimalDigits: decimal,
        symbol: showSign ? '€' : '',
      ).format(this).trim();
}
