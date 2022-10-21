import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/platform/platform.dart';

void main() {
  group('Global platform', () {
    test(
      'should forward the call to retrieve the platform is web',
      () async {
        // arrange
        const isWeb = true;
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = false
          ..isWeb = true
          ..isWindows = false
          ..isMacOS = false
          ..isLinux = false;

        // act
        final result = platformBase.isWeb;
        // assert
        expect(result, isWeb);
      },
    );
    test(
      'should forward the call to retrieve the platform is mobile',
      () async {
        // arrange
        const isMobile = true;
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = true
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = false
          ..isLinux = false;

        // act
        final result = platformBase.isMobile;
        // assert
        expect(result, isMobile);
      },
    );
    test(
      'should forward the call to retrieve the platform is not mobile',
      () async {
        // arrange
        const isMobile = false;
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = false
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = true
          ..isLinux = false;

        // act
        final result = platformBase.isMobile;
        // assert
        expect(result, isMobile);
      },
    );
    test(
      'should forward the call to retrieve the platform is desktop',
      () async {
        // arrange
        const isDesktop = true;
        final platformBase = Platform()
          ..isAndroid = false
          ..isIOS = false
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = false
          ..isLinux = true;

        // act
        final result = platformBase.isDesktop;
        // assert
        expect(result, isDesktop);
      },
    );
    test(
      'should forward the call to retrieve the platform is not desktop',
      () async {
        // arrange
        const isDesktop = false;
        final platformBase = Platform()
          ..isAndroid = true
          ..isIOS = false
          ..isWeb = false
          ..isWindows = false
          ..isMacOS = false
          ..isLinux = false;
        // act
        final result = platformBase.isDesktop;
        // assert
        expect(result, isDesktop);
      },
    );
  });
}
