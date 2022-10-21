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
  Platform? tPlatformBase;

  setUp(() {
    tPlatformBase = Platform()
      ..isAndroid = false
      ..isIOS = false
      ..isWeb = false
      ..isWindows = false
      ..isMacOS = false
      ..isLinux = false;
    PackageInfo.setMockInitialValues(
      appName: tAppName,
      packageName: tPackageName,
      version: tVersion,
      buildNumber: tBuildNumber,
      buildSignature: tBuildSignature,
      installerStore: '',
    );
    mockPackageInfo = PackageInfo.fromPlatform();
    packageInfoImpl = PackageInfoImpl(packageInfo: mockPackageInfo!);
  });

  group('PackageInfo', () {
    test(
      'should forward the call to PackageInfo init to retrieve the data',
      () async {
        const tPlatform = 'iOS';
        tPlatformBase!.isIOS = true;
        // act
        await packageInfoImpl!.initPackageInfo(tPlatformBase!);
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
        tPlatformBase!.isIOS = true;
        // act
        final result = packageInfoImpl!.getPlatform(tPlatformBase!);
        // assert
        expect(result, tPlatform);
      },
    );
    test(
      'should forward the call to retrieve the platform android',
      () async {
        // arrange
        const tPlatform = 'android';
        tPlatformBase!.isAndroid = true;
        // act
        final result = packageInfoImpl!.getPlatform(tPlatformBase!);
        // assert
        expect(result, tPlatform);
      },
    );
    test(
      'should forward the call to retrieve the platform macos',
      () async {
        // arrange
        const tPlatform = 'macos';
        tPlatformBase!.isMacOS = true;
        // act
        final result = packageInfoImpl!.getPlatform(tPlatformBase!);
        // assert
        expect(result, tPlatform);
      },
    );
    test(
      'should forward the call to retrieve the platform windows',
      () async {
        // arrange
        const tPlatform = 'windows';
        tPlatformBase!.isWindows = true;
        // act
        final result = packageInfoImpl!.getPlatform(tPlatformBase!);
        // assert
        expect(result, tPlatform);
      },
    );
    test(
      'should forward the call to retrieve the platform linux',
      () async {
        // arrange
        const tPlatform = 'linux';
        tPlatformBase!.isLinux = true;
        // act
        final result = packageInfoImpl!.getPlatform(tPlatformBase!);
        // assert
        expect(result, tPlatform);
      },
    );
  });
}
