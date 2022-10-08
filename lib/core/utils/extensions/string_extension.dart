import 'dart:convert';

extension StringExtensions on String? {
  /// Returns `true` if this nullable char sequence is either `null` or empty.
  bool isNullOrEmpty() => this == null || this!.isEmpty;

  /// Returns `false` if this nullable char sequence is either `null` or empty.
  bool isNotNullOrEmpty() => this != null && this!.isNotEmpty;

  /// Returns a progression that goes over the same range in the opposite
  /// direction with the same step.
  String reversed() {
    var res = '';
    for (var i = this!.length; i >= 0; --i) {
      res = this![i];
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

  ///  Replaces part of string after the first occurrence of given delimiter
  ///  with the [replacement] string.
  ///  If the string does not contain the delimiter, returns [defaultValue]
  ///  which defaults to the original string.
  String? replaceAfter(
    String delimiter,
    String replacement, [
    String? defaultValue,
  ]) {
    if (this == null) {
      return null;
    }
    final index = this!.indexOf(delimiter);
    return (index == -1)
        ? defaultValue!.isNullOrEmpty()
            ? this
            : defaultValue
        : this!.replaceRange(index + 1, this!.length, replacement);
  }

  /// Replaces part of string before the first occurrence of given delimiter
  /// with the [replacement] string.
  /// If the string does not contain the delimiter,
  /// returns [missingDelimiterValue!] which defaults to the original string.
  String? replaceBefore(
    String delimiter,
    String replacement, [
    String? defaultValue,
  ]) {
    if (this == null) {
      return null;
    }
    final index = this!.indexOf(delimiter);
    return (index == -1)
        ? defaultValue!.isNullOrEmpty()
            ? this
            : defaultValue
        : this!.replaceRange(0, index, replacement);
  }

  ///Returns `true` if at least one element matches the given [predicate].
  /// the [predicate] should have only one character
  bool anyChar(bool Function(String element) predicate) =>
      this?.split('').any((s) => predicate(s)) ?? false;

  /// Returns last symbol of string or empty string if `this` is null or empty
  String get last => isNullOrEmpty() ? '' : this![this!.length - 1];

  /// Returns `true` if strings are equals without matching case
  bool equalsIgnoreCase(String? other) =>
      (this == null && other == null) ||
      (this != null &&
          other != null &&
          this?.toLowerCase() == other.toLowerCase());

  String orEmpty() => this ?? '';
}
