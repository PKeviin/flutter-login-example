class Patterns {
  static String url =
      r'(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?';
  static String phone =
      r'^(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})$';
  static String email =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String int = r'^[+-]?\d+(\.\d+)?$';
  static String double = r'^[+-]?\d+(\.\d+)?$';
  static String password = r'^.{8,32}$';
  static String dateNumber =
      r'^.*(([0-9]{2})[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2,4})).*$';
  static String dateString = r'^.*((\d{2}).([a-zA-Z]{3,9}).(\d{2,4})).*$';
}

class UtilsValidator {
  /// Email validation
  static bool validateEmail(String value) =>
      RegExp(Patterns.email).hasMatch(value);

  /// Phone Number Validation
  static bool validationTel(String value) =>
      RegExp(Patterns.phone).hasMatch(value);

  /// URL Validation
  static bool validationUrl(String value) =>
      RegExp(Patterns.url).hasMatch(value);

  /// Validation of a duplicate
  static bool validationDouble(String value) =>
      RegExp(Patterns.double).hasMatch(value);

  /// Validating an int
  static bool validationInt(String value) =>
      RegExp(Patterns.int).hasMatch(value);

  /// Password validation
  static bool validationPassword(String value) =>
      RegExp(Patterns.password).hasMatch(value);

  /// Date validation
  static bool validationDate(String value) =>
      RegExp(Patterns.dateNumber).hasMatch(value) ||
      RegExp(Patterns.dateString).hasMatch(value);
}
