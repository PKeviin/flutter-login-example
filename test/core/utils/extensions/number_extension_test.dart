import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/extensions/number_extension.dart';

void main() {
  group('NumExtensions', () {
    group('NumExtensions', () {
      test('Formats a number with thousand and comma separator (en)', () {
        // arrange
        const number = 10;
        // assert
        expect(number.formatCurrency(), '€10.00');
        expect(number.formatCurrency(decimal: 0, showSign: false), '10');
        expect(number.formatCurrency(decimal: 0), '€10');
      });
    });
  });
}
