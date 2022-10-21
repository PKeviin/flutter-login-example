import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/credentials.dart';
import 'package:template/core/utils/extensions/string_extension.dart';

import '../fixtures/fixure_reader.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('dotenv', () {
    group('.env.prod', () {
      setUp(() {
        dotenv.testLoad(fileInput: fixture('../../.env.prod'));
      });

      test('Incorrect environement should be rejected', () {
        const tResult = 'prod';
        // arrange
        final env = dotenv.env['ENV'];
        final isProd = env == tResult;
        // assert
        expect(env, tResult);
        expect(env, Credential.env);
        expect(isProd, Credential.isProduction);
        expect(!isProd, Credential.isDev);
        expect(!isProd, Credential.isPreprod);
      });

      test('incorrect api url should be rejected', () {
        // arrange
        final apiURL = dotenv.env['API_URL'];
        // assert
        expect(apiURL.isNotNullOrEmpty(), true);
        expect(apiURL, Credential.apiUrl);
      });

      test('nullable fallback getter works', () {
        expect(dotenv.env['FCM_ID'], isNotNull);
        expect(dotenv.env['API_PORT'], isNotNull);
        expect(dotenv.env['API_VERSION'], isNotNull);
        expect(dotenv.env['SENTRY_URL'], isNotNull);
        expect(dotenv.env['WIREDASH_ID'], isNotNull);
        expect(dotenv.env['WIREDASH_KEY'], isNotNull);

        expect(Credential.fcmId, isNotNull);
        expect(Credential.port, isNotNull);
        expect(Credential.apiVersion, isNotNull);
        expect(Credential.sentryUrl, isNotNull);
        expect(Credential.wiredashId, isNotNull);
        expect(Credential.wiredashKey, isNotNull);
      });
    });
  });
}
