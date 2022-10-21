import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/extensions/date_time_extension.dart';

void main() {
  group('DateTimeExtension', () {
    final tDateTime = DateTime(2022, 10, 05, 20, 10);

    test('should change a date to toEuFormat', () {
      // assert
      expect(tDateTime.toEuFormat(), '05/10/2022');
    });

    test('should change a date to toEuTimeFormat', () {
      // assert
      expect(tDateTime.toEuTimeFormat(), '05/10/2022 20:10');
    });

    test('should change a date to toEuFormatShortYear', () {
      // assert
      expect(tDateTime.toEuFormatShortYear(), '05/10/22');
    });

    test('should change a date to toEuFormatNoYear', () {
      // assert
      expect(tDateTime.toEuFormatNoYear(), '05/10');
    });

    test('should change a date to toDateExpiryCardPaiement', () {
      // assert
      expect(tDateTime.toDateExpiryCardPaiement(), '10/22');
    });

    test('should change a date to toTime (en)', () {
      // assert
      expect(tDateTime.toTime(), '8:10');
    });
  });
}
