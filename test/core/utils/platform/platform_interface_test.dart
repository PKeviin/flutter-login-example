import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/platform/platform.dart';

void main() {
  group('Global platform', () {
    Platform? platformBase;
    setUp(() {
      platformBase = Platform()
        ..isAndroid = false
        ..isIOS = false
        ..isWeb = false
        ..isWindows = false
        ..isMacOS = false
        ..isLinux = false;
    });

    test(
      'should forward the call to retrieve the platform is web',
      () async {
        // arrange
        const isWeb = true;
        platformBase!.isWeb = true;
        // act
        final result = platformBase!.isWeb;
        // assert
        expect(result, isWeb);
      },
    );
    test(
      'should forward the call to retrieve the platform is mobile',
      () async {
        // arrange
        const isMobile = true;
        platformBase!.isIOS = true;
        // act
        final result = platformBase!.isMobile;
        // assert
        expect(result, isMobile);
      },
    );
    test(
      'should forward the call to retrieve the platform is not mobile',
      () async {
        // arrange
        const isMobile = false;
        platformBase!.isMacOS = true;
        // act
        final result = platformBase!.isMobile;
        // assert
        expect(result, isMobile);
      },
    );
    test(
      'should forward the call to retrieve the platform is desktop',
      () async {
        // arrange
        const isDesktop = true;
        platformBase!.isLinux = true;
        // act
        final result = platformBase!.isDesktop;
        // assert
        expect(result, isDesktop);
      },
    );
    test(
      'should forward the call to retrieve the platform is not desktop',
      () async {
        // arrange
        const isDesktop = false;
        platformBase!.isAndroid = true;
        // act
        final result = platformBase!.isDesktop;
        // assert
        expect(result, isDesktop);
      },
    );
  });
}
