import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/impl/picker_file/picker_file_impl.dart';

class MockFilePicker extends Mock implements FilePicker {}

void main() {
  PickerFileImpl? pickerFileImpl;
  MockFilePicker? mockFilePicker;

  setUp(() {
    mockFilePicker = MockFilePicker();
    pickerFileImpl = PickerFileImpl(filePicker: mockFilePicker!);
  });

  group('FilePicker', () {
    test(
      'should forward the call to FilePicker.pickFiles()',
      () async {
        // arrange
        when(
          () => mockFilePicker!.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          ),
        ).thenAnswer((_) async => null);
        // act
        await pickerFileImpl!.pickerFiles(
          allowMultiple: true,
          allowedExtensions: ['pdf'],
        );
        // assert
        verify(
          () => mockFilePicker!.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          ),
        ).called(1);
      },
    );
    test('should return a list of files', () async {
      // arrange
      final tResult = FilePickerResult(
        [
          PlatformFile(size: 10, name: 'file1', path: 'path1'),
          PlatformFile(size: 10, name: 'file2', path: 'path2'),
        ],
      );
      when(
        () => mockFilePicker!.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        ),
      ).thenAnswer((_) async => tResult);
      // act
      final result = await pickerFileImpl!
          .pickerFiles(allowMultiple: true, allowedExtensions: ['pdf']);
      // assert
      verify(
        () => mockFilePicker!.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        ),
      ).called(1);
      expect(result, isA<List<File>>());
      expect(result[0].path, tResult.files[0].path);
      expect(result[1].path, tResult.files[1].path);
    });
  });
}
