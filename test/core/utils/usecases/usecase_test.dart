import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/usecases/usecase.dart';

void main() {
  group('Usecases', () {
    group('NoParams', () {
      test('NoParams Equatable', () {
        // arrange
        final noParams = NoParams();
        final noParams2 = NoParams();
        // assert
        expect(noParams == noParams2, true);
      });
    });
  });
}
