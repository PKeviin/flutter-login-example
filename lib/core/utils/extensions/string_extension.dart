import 'dart:convert';

extension StringExtensions on String? {
  /// Returns `true` if this nullable char sequence is either `null` or empty.
  bool isNullOrEmpty() => this == null || this!.isEmpty;

  /// Returns `false` if this nullable char sequence is either `null` or empty.
  bool isNotNullOrEmpty() => this != null && this!.isNotEmpty;

  /// Returns a progression that goes over the same range in the opposite
  /// direction with the same step.
  String? reversed() {
    if (this == null) return null;
    var res = '';
    for (var i = this!.length - 1; i >= 0; --i) {
      res += this![i];
    }
    return res;
  }

  /// Returns the value of this number as an [int]
  int toInt() => int.parse(this!);

  /// Returns the value of this number as an [int] or null if can not be parsed.
  int? toIntOrNull() => this == null ? null : int.tryParse(this!);

  /// Returns the value of this number as an [double]
  double toDouble() => double.parse(this!);

  /// Returns the value of this number as an [double]
  /// or null if can not be parsed.
  double? toDoubleOrNull() => this == null ? null : double.tryParse(this!);

  /// Returns true if 'this' is "true", otherwise - false
  bool toBoolean() => this?.toLowerCase() == 'true';

  /// Returns base 64
  String toBase64() => utf8.fuse(base64).encode(this!);

  /// Returns the value of this date as an [DateTime]
  DateTime toDateTime() => DateTime.parse(this!);

  /// Returns the value of this date as an [DateTime]
  /// or null if can not be parsed.
  DateTime? toDateTimeOrNull() => DateTime.tryParse(this!);

  /// Returns last symbol of string or empty string if `this` is null or empty
  String get last => isNullOrEmpty() ? '' : this![this!.length - 1];

  /// Returns `true` if strings are equals without matching case
  bool equalsIgnoreCase(String? other) =>
      (this == null && other == null) ||
      (this != null &&
          other != null &&
          this?.toLowerCase() == other.toLowerCase());

  /// Returns empty if null
  String orEmpty() => this ?? '';

  /// Formatting phone numbers that have different formats
  String? formatTelNumber() {
    var result = '';
    if (this != '' && this != null) {
      result = this!
          .replaceAll('(0)', '')
          .replaceAll(' ', '')
          .replaceAll(RegExp(r'[\.-]'), '');
      final regex = RegExp(r'^[^0\+]');
      if (regex.hasMatch(this!)) {
        result = '+${this!.replaceAll(' ', '')}';
      }
    } else {
      return null;
    }
    return result;
  }
}
