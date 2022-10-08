import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'app.dart';
import 'core/credentials.dart';
import 'core/utils/utils.dart';

Future main() async {
  await runZonedGuarded(() async {
    await dotenv.load(fileName: '.env.preprod');
    await Utils.init();
    await SentryFlutter.init(
      (options) {
        options
          ..dsn = Credential.sentryUrl
          ..tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(const ProviderScope(child: App())),
    );
  }, (error, stacktrace) async {
    await Utils.traceLogError('dart error', error, stacktrace);
  });
}
