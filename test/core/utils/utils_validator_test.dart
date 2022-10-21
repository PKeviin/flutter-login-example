import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/utils_validator.dart';

void main() {
  group('Utils Validator', () {
    test('validator email', () {
      // assert
      expect(UtilsValidator.validateEmail('test@gmail.com'), true);
      expect(UtilsValidator.validateEmail('test@ok.lol'), true);
      expect(UtilsValidator.validateEmail(' test@gmail.com '), false);
      expect(UtilsValidator.validateEmail('testgmail.com'), false);
      expect(UtilsValidator.validateEmail('@yahoo.fr'), false);
    });

    test('validator phone', () {
      // assert
      expect(UtilsValidator.validationTel('0601010101'), true);
      expect(UtilsValidator.validationTel('06.01.01.01.01'), true);
      expect(UtilsValidator.validationTel('+33612457890'), true);
      expect(UtilsValidator.validationTel('+33 645874512'), true);
      expect(UtilsValidator.validationTel('+336 58 74 51 12'), true);
      expect(UtilsValidator.validationTel('+33665z58740'), false);
      expect(UtilsValidator.validationTel('075489541d'), false);
      expect(UtilsValidator.validationTel('test2'), false);
      expect(UtilsValidator.validationTel('065485'), false);
      expect(UtilsValidator.validationTel(' 0754895415'), false);
      expect(UtilsValidator.validationTel('06010101010101010101'), false);
    });

    test('validator password', () {
      // assert
      expect(UtilsValidator.validationPassword('1234'), false);
      expect(UtilsValidator.validationPassword('12345s'), false);
      expect(UtilsValidator.validationPassword('1232180un4'), true);
      expect(UtilsValidator.validationPassword('12DdzadA34'), true);
      expect(UtilsValidator.validationPassword('12DdzadA34%'), true);
    });

    test('validator double', () {
      // assert
      expect(UtilsValidator.validationDouble('1234'), true);
      expect(UtilsValidator.validationDouble('12.56'), true);
      expect(UtilsValidator.validationDouble('12,56'), false);
      expect(UtilsValidator.validationDouble('123aze'), false);
      expect(UtilsValidator.validationDouble('aze'), false);
    });

    test('validator int', () {
      // assert
      expect(UtilsValidator.validationInt('1'), true);
      expect(UtilsValidator.validationInt('0101501'), true);
      expect(UtilsValidator.validationInt('1234'), true);
      expect(UtilsValidator.validationInt('12.56'), true);
      expect(UtilsValidator.validationInt('12,56'), false);
      expect(UtilsValidator.validationInt('123aze'), false);
      expect(UtilsValidator.validationInt('aze'), false);
    });

    test('validator url', () {
      // assert
      expect(UtilsValidator.validationUrl('https://www.google.com'), true);
      expect(UtilsValidator.validationUrl('http://google.com'), true);
      expect(UtilsValidator.validationUrl('google.com'), true);
      expect(UtilsValidator.validationUrl('google'), false);
      expect(UtilsValidator.validationUrl('https://google'), false);
    });

    test('validator date', () {
      // assert
      expect(UtilsValidator.validationDate('2021/04/10'), true);
      expect(UtilsValidator.validationDate('20-10-2021'), true);
      expect(UtilsValidator.validationDate('10-fev-2021'), true);
      expect(UtilsValidator.validationDate('10/fev/2021'), true);
      expect(UtilsValidator.validationDate('10/fevrier/2021'), true);
      expect(UtilsValidator.validationDate('10/mars/22'), true);
      expect(UtilsValidator.validationDate('mars/22'), false);
      expect(UtilsValidator.validationDate('google.com'), false);
      expect(UtilsValidator.validationDate('test'), false);
    });
  });
}
