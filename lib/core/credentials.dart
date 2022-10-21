import 'package:flutter_dotenv/flutter_dotenv.dart';

class Credential {
  Credential._(); // coverage:ignore-line

  /// ENVIRONEMENT
  static final String env = dotenv.env['ENV']!;
  static final bool isProduction = env == 'prod';
  static final bool isPreprod = env == 'preprod';
  static final bool isDev = env != 'prod' && env != 'preprod';
  static final String fcmId = dotenv.env['FCM_ID']!;

  /// API
  static final String apiUrl = dotenv.env['API_URL']!;
  static final String port = dotenv.env['API_PORT']!;
  static final String apiVersion = dotenv.env['API_VERSION']!;
  // static final String apiBase = '$apiUrl:$port/$apiVersion';

  /// SENTRY
  static final String sentryUrl = dotenv.env['SENTRY_URL']!;

  /// WIREDASH
  static final String wiredashId = dotenv.env['WIREDASH_ID']!;
  static final String wiredashKey = dotenv.env['WIREDASH_KEY']!;
}
