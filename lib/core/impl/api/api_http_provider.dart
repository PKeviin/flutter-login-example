import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/login/presentation/provider/user_provider.dart';
import '../../providers/locale_provider.dart';
import '../logger/logger_provider.dart';
import '../platform_info/package_info_provider.dart';
import 'api_http_impl.dart';

final apiHttpImplProvider = Provider<ApiHttpImpl>((ref) {
  final user = ref.watch(userProvider.notifier);
  final local = ref.watch(localeProvider.notifier);
  final logger = ref.watch(loggerImplProvider);
  return ApiHttpImpl(
    logger: logger,
    localeState: local,
    userState: user,
    platform: platformApp,
  );
});
