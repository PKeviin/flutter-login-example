import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../utils/platform/platform.dart';
import 'package_info_provider.dart';
import 'package_info_repository.dart';

class PackageInfoImpl implements PackageInfoRepository {
  PackageInfoImpl({
    required this.packageInfo,
  });
  Future<PackageInfo> packageInfo;

  /// Init package info
  @override
  Future<void> initPackageInfo(Platform platformBase) async {
    await getVersion();
    await getBuildNumber();
    getPlatform(platformBase);
  }

  /// Application version retrieval
  @override
  Future<String> getVersion() async {
    await packageInfo.then((packageInfo) {
      versionApp = packageInfo.version;
    });
    debugPrint('app version [$versionApp]');
    return versionApp;
  }

  /// Application build number retrieval
  @override
  Future<String> getBuildNumber() async {
    await packageInfo.then((packageInfo) {
      buildNumberApp = packageInfo.buildNumber;
    });
    debugPrint('build number [$buildNumberApp]');
    return buildNumberApp;
  }

  /// Get platform
  @override
  String getPlatform(Platform platformBase) {
    if (platformBase.isWeb) {
      platformApp = 'web';
    } else if (platformBase.isAndroid) {
      platformApp = 'android';
    } else if (platformBase.isIOS) {
      platformApp = 'iOS';
    } else if (platformBase.isMacOS) {
      platformApp = 'macos';
    } else if (platformBase.isWindows) {
      platformApp = 'windows';
    } else if (platformBase.isLinux) {
      platformApp = 'linux';
    }
    debugPrint('platform [$platformApp]');
    return platformApp;
  }
}
