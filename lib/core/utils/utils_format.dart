import 'package:intl/intl.dart';

class UtilsFormat {
  /// Formatting phone numbers that have different formats
  /// [tel] phone number to format
  static String formatTelNumber(String tel) {
    var result = '';
    if (tel != '') {
      result = tel
          .replaceAll('(0)', '')
          .replaceAll(' ', '')
          .replaceAll(RegExp(r'[\.-]'), '');
      final regex = RegExp(r'^[^0\+]');
      if (regex.hasMatch(tel)) {
        result = '+$tel';
      }
    }
    return result;
  }

  /// Formats a number with thousand and comma separator
  /// [number] number to format
  static String formatCurrency(
    String? number, {
    int decimal = 2,
    bool showSign = true,
  }) {
    if (number == null || number == '') {
      return '';
    }
    return NumberFormat.currency(
      locale: Intl.getCurrentLocale(),
      decimalDigits: decimal,
      symbol: showSign ? '€' : '',
    ).format(number).trim();
  }

  // only to use in this case
  static List<String> splitStringByLength(String str, int length) => [
        str.substring(0, length),
        str.substring(length, length * 2),
        str.substring(length * 2, length * 3),
        str.substring(length * 3, length * 4)
      ];

  //only to use in this case
  static List<String> splitStringByLengthDate(String str, int length) =>
      [str.substring(0, length), str.substring(length, length * 2)];

  /// Converting a date string to a string date experiation
  static String fromatStringToDateExpiry(String date) {
    final dateTime = DateTime.tryParse(date);
    if (dateTime != null) {
      return '${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString().substring(dateTime.year.toString().length - 2)}';
    } else {
      return '';
    }
  }
}
