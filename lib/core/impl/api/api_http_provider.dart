import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/login/presentation/provider/user_provider.dart';
import '../../providers/locale_provider.dart';
import 'api_http_impl.dart';

final apiHttpImplProvider = Provider<ApiHttpImpl>(
  (ref) => ApiHttpImpl(
    ref.watch(userProvider.notifier),
    ref.watch(localeProvider.notifier),
  ),
);
