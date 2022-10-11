import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_info_impl.dart';

/// NetworkInfo provider
final networkInfoProvider =
    Provider<InternetConnectionChecker>((ref) => InternetConnectionChecker());

/// NetworkInfoImpl provider
final networkInfoImplProvider = Provider<NetworkInfoImpl>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  return NetworkInfoImpl(networkInfo: networkInfo);
});
