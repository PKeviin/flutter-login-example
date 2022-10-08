import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/utils/utils.dart';

Future main() async {
  await runZonedGuarded(() async {
    await dotenv.load(fileName: '.env.dev');
    await Utils.init();
    runApp(const ProviderScope(child: App()));
  }, (error, stacktrace) async {
    await Utils.traceLogError('dart error', error, stacktrace);
  });
}
