import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:template/core/impl/package_info/package_info_impl.dart';
import 'package:template/core/impl/package_info/package_info_provider.dart';
import 'package:template/core/utils/platform/platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  PackageInfoImpl? packageInfoImpl;
  Future<PackageInfo>? mockPackageInfo;

  const tVersion = '1.0.1';
  const tBuildNumber = '12';
  const tAppName = 'App test';
  const tPackageName = 'com.app.test';
  const tBuildSignature = '100';

  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: tAppName,
      packageName: tPackageName,
      version: tVersion,
      buildNumber: tBuildNumber,
      buildSignature: tBuildSignature,
    );
    mockPackageInfo = PackageInfo.fromPlatform();
    packageInfoImpl = PackageInfoImpl(packageInfo: mockPackageInfo!);
  });

  group('PackageInfo', () {
    test(
      'should forward the call to PackageInfo init to retrieve the data',
      () async {
        const tPlatform = 'iOS';
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = true
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = false
          ..isLinux = false;
        // act
        await packageInfoImpl!.initPackageInfo(platformBase);
        // assert
        expect(versionApp, tVersion);
        expect(buildNumberApp, tBuildNumber);
        expect(platformApp, tPlatform);
      },
    );
    test(
      'should forward the call to PackageInfo to retrieve the version number',
      () async {
        // act
        final result = await packageInfoImpl!.getVersion();
        // assert
        expect(result, tVersion);
      },
    );
    test(
      'should forward the call to PackageInfo to retrieve the build number',
      () async {
        // act
        final result = await packageInfoImpl!.getBuildNumber();
        // assert
        expect(result, tBuildNumber);
      },
    );
    test(
      'should forward the call to retrieve the platform iOS',
      () async {
        // arrange
        const tPlatform = 'iOS';
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = true
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = false
          ..isLinux = false;

        // act
        final result = packageInfoImpl!.getPlatform(platformBase);
        // assert
        expect(result, tPlatform);
      },
    );
    test(
      'should forward the call to retrieve the platform android',
      () async {
        // arrange
        const tPlatform = 'android';
        final platformBase = Platform()
          ..isAndroid = true
          ..isIOS = false
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = false
          ..isLinux = false;

        // act
        final result = packageInfoImpl!.getPlatform(platformBase);
        // assert
        expect(result, tPlatform);
      },
    );
    test(
      'should forward the call to retrieve the platform macos',
      () async {
        // arrange
        const tPlatform = 'macos';
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = false
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = true
          ..isLinux = false;

        // act
        final result = packageInfoImpl!.getPlatform(platformBase);
        // assert
        expect(result, tPlatform);
      },
    );
    test(
      'should forward the call to retrieve the platform windows',
      () async {
        // arrange
        const tPlatform = 'windows';
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = false
          ..isWeb = false
          ..isWindows = true
          ..isMacOS = false
          ..isLinux = false;

        // act
        final result = packageInfoImpl!.getPlatform(platformBase);
        // assert
        expect(result, tPlatform);
      },
    );
    test(
      'should forward the call to retrieve the platform linux',
      () async {
        // arrange
        const tPlatform = 'linux';
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = false
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = false
          ..isLinux = true;

        // act
        final result = packageInfoImpl!.getPlatform(platformBase);
        // assert
        expect(result, tPlatform);
      },
    );
  });
}
