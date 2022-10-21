import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/extensions/string_extension.dart';

void main() {
  group('StringExtensions', () {
    const tString = 'test';
    const tStringInt = '10';
    const tStringDouble = '10.2';
    const tStringBool = 'true';
    const tStringDateTime = '2021-01-10';
    const tStringEmpty = '';
    String? tStringNull;

    group('StringExtensions', () {
      test(
          'should returns `true` if this nullable char sequence is either `null` or empty',
          () {
        // assert
        expect(tString.isNullOrEmpty(), false);
        expect(tStringEmpty.isNullOrEmpty(), true);
        expect(tStringNull.isNullOrEmpty(), true);
      });

      test(
          'should returns `false` if this nullable char sequence is either `null` or empty',
          () {
        // assert
        expect(tString.isNotNullOrEmpty(), true);
        expect(tStringEmpty.isNotNullOrEmpty(), false);
        expect(tStringNull.isNotNullOrEmpty(), false);
      });

      test(
          'should returns a progression that goes over the same range in the opposite '
          'direction with the same step.', () {
        // assert
        expect(tString.reversed(), 'tset');
        expect(tStringEmpty.reversed(), '');
        expect(tStringNull.reversed(), null);
      });

      test('should returns the value of this number as an [int]', () {
        // assert
        expect(tStringInt.toInt(), 10);
      });

      test(
          'should returns the value of this number as an [int] '
          'or null if can not be parsed.', () {
        // assert
        expect(tStringInt.toIntOrNull(), 10);
        expect(tString.toIntOrNull(), null);
        expect(tStringEmpty.toIntOrNull(), null);
        expect(tStringNull.toIntOrNull(), null);
      });

      test('should returns the value of this number as an [double]', () {
        // assert
        expect(tStringDouble.toDouble(), 10.2);
        expect(tStringInt.toDouble(), 10);
      });

      test(
          'should returns the value of this number as an [double] '
          'or null if can not be parsed.', () {
        // assert
        expect(tStringDouble.toDoubleOrNull(), 10.2);
        expect(tStringInt.toDoubleOrNull(), 10);
        expect(tString.toDoubleOrNull(), null);
        expect(tStringEmpty.toDoubleOrNull(), null);
        expect(tStringNull.toDoubleOrNull(), null);
      });

      test('should returns true if this is true, otherwise - false', () {
        // assert
        expect(tStringBool.toBoolean(), true);
        expect(tStringDouble.toBoolean(), false);
        expect(tStringInt.toBoolean(), false);
        expect(tString.toBoolean(), false);
        expect(tStringEmpty.toBoolean(), false);
        expect(tStringNull.toBoolean(), false);
      });

      test('should returns base 64', () {
        // assert
        expect(tString.toBase64(), 'dGVzdA==');
        expect(tStringDouble.toBase64(), 'MTAuMg==');
        expect(tStringInt.toBase64(), 'MTA=');
        expect(tStringEmpty.toBase64(), '');
      });

      test('should returns the value of this date as an [DateTime]', () {
        // assert
        expect(tStringDateTime.toDateTime(), DateTime(2021, 01, 10));
      });

      test(
          'should returns the value of this date as an [DateTime] or null if can not be parsed',
          () {
        // assert
        expect(tStringDateTime.toDateTimeOrNull(), DateTime(2021, 01, 10));
        expect(tStringBool.toDateTimeOrNull(), null);
        expect(tStringDouble.toDateTimeOrNull(), null);
        expect(tStringInt.toDateTimeOrNull(), null);
        expect(tString.toDateTimeOrNull(), null);
        expect(tStringEmpty.toDateTimeOrNull(), null);
      });

      test(
          'should returns last symbol of string or empty string if `this` is null or empty',
          () {
        // assert
        expect(tString.last, 't');
        expect(tStringDateTime.last, '0');
        expect(tStringDouble.last, '2');
      });

      test('should returns `true` if strings are equals without matching case',
          () {
        // assert
        expect(
          tString.toLowerCase().equalsIgnoreCase(tString.toUpperCase()),
          true,
        );
        expect(tString.equalsIgnoreCase(tString), true);
        expect(tStringDouble.equalsIgnoreCase(tStringDouble), true);
        expect(tString.equalsIgnoreCase(tStringDouble), false);
      });

      test('should returns empty if null', () {
        // assert
        expect(tString.orEmpty(), tString);
        expect(tStringDouble.orEmpty(), tStringDouble);
        expect(tStringEmpty.orEmpty(), tStringEmpty);
        expect(tStringNull.orEmpty(), '');
      });

      test(
          'should formatting phone numbers that have different'
          ' formats [tel] phone number to format', () {
        // arrange
        const tResult = '0626272829';
        const tStringPhone = '0626272829';
        const tStringPhone2 = '+33 06 26 27 28 29';
        const tStringPhone3 = '(0)06 26 27 28 29';
        const tStringPhone4 = '06-26-27-28-29';
        const tStringPhone5 = '06.26.27.28.29';
        const tStringPhone6 = '0626272829  ';

        // assert
        expect(tStringPhone.formatTelNumber(), tResult);
        expect(tStringPhone2.formatTelNumber(), '+330626272829');
        expect(tStringPhone3.formatTelNumber(), '+(0)0626272829');
        expect(tStringPhone4.formatTelNumber(), tResult);
        expect(tStringPhone5.formatTelNumber(), tResult);
        expect(tStringPhone6.formatTelNumber(), tResult);
        expect(tStringEmpty.formatTelNumber(), null);
        expect(tStringNull.formatTelNumber(), null);
      });
    });
  });
}
