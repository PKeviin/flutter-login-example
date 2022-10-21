import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package_info_impl.dart';

/// App information without provider
/// Not in a provider because the variables are used before the runApp
String versionApp = '';
String buildNumberApp = '';
String platformApp = '';

/// Package info without provider
final packageInfo = PackageInfo.fromPlatform();

/// Package Info Impl provider
final packageInfoImplProvider = Provider<PackageInfoImpl>(
  (ref) => PackageInfoImpl(packageInfo: packageInfo),
);
