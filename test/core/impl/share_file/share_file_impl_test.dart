import 'package:cross_file/cross_file.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plus/share_plus.dart';
import 'package:template/core/impl/share_file/share_file_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  ShareFileImpl? shareFileImpl;

  setUp(() {
    shareFileImpl = ShareFileImpl();
  });

  group('Share Plus', () {
    test('should forward the call to Share.shareXFiles (success)', () async {
      // arrange
      const tShareResultStatus = ShareResultStatus.success;
      const MethodChannel('dev.fluttercommunity.plus/share')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'shareFilesWithResult') {
          return 'success';
        }
        return null;
      });
      final tXFiles = <XFile>[
        XFile('path1', mimeType: 'image/jpg'),
        XFile('path1', mimeType: 'image/png')
      ];
      const tName = 'name';
      // act
      final result =
          await shareFileImpl!.shareXFiles(files: tXFiles, text: tName);
      // assert
      expect(result, isA<ShareResult>());
      expect(result.status, tShareResultStatus);
    });

    test('should forward the call to Share.shareXFiles (dismissed)', () async {
      // arrange
      const tShareResultStatus = ShareResultStatus.dismissed;
      const MethodChannel('dev.fluttercommunity.plus/share')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'shareFilesWithResult') {
          return '';
        }
        return null;
      });
      final tXFiles = <XFile>[
        XFile('path1', mimeType: 'image/jpg'),
        XFile('path1', mimeType: 'image/png')
      ];
      const tName = 'name';
      // act
      final result =
          await shareFileImpl!.shareXFiles(files: tXFiles, text: tName);
      // assert
      expect(result, isA<ShareResult>());
      expect(result.status, tShareResultStatus);
    });

    test('should forward the call to Share.shareXFiles (unavailable)',
        () async {
      // arrange
      const tShareResultStatus = ShareResultStatus.unavailable;
      const MethodChannel('dev.fluttercommunity.plus/share')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'shareFilesWithResult') {
          return null;
        }
        return null;
      });
      final tXFiles = <XFile>[
        XFile('path1', mimeType: 'image/jpg'),
        XFile('path1', mimeType: 'image/png')
      ];
      const tName = 'name';
      // act
      final result =
          await shareFileImpl!.shareXFiles(files: tXFiles, text: tName);
      // assert
      expect(result, isA<ShareResult>());
      expect(result.status, tShareResultStatus);
    });
  });
}
