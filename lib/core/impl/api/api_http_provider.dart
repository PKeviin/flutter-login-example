import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../features/commons/providers/locale_provider.dart';
import '../../../features/login/presentation/providers/user_provider.dart';
import '../../credentials.dart';
import '../package_info/package_info_provider.dart';
import 'api_http_impl.dart';

final apiHttpImplProvider = Provider<ApiHttpImpl>((ref) {
  final user = ref.watch(userProvider.notifier);
  final local = ref.watch(localeProvider.notifier);
  return ApiHttpImpl(
    client: http.Client(),
    locale: local.getLanguageCode,
    token: user.getToken,
    platform: platformApp,
    apiUrl: Credential.apiUrl,
  );
});
