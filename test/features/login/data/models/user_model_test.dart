import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:template/features/login/data/models/user_model.dart';
import 'package:template/features/login/domain/entities/user.dart';

import '../../../../fixtures/fixure_reader.dart';

void main() {
  final tUserModel = UserModel(
    name: 'Name test',
    lastName: 'Last Name test',
    email: 'Email test',
    token: 'Token test',
    id: 1,
    mobile: 'Mobile test',
  );

  test('should be a subclass of UserModel entity', () {
    // assert
    expect(tUserModel, isA<User>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));
      // act
      final result = UserModel.fromJson(jsonMap);
      // assert
      // TODO(pkeviin): do not work
      expect(result, tUserModel);
    });

    test('should return a model without mobile field', () async {
      // arrange
      final tUserModel = UserModel(
        name: 'Name test',
        lastName: 'Last Name test',
        email: 'Email test',
        token: 'Token test',
        id: 1,
      );
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('user_without_mobile.json'));
      // act
      final result = UserModel.fromJson(jsonMap);
      // assert
      // TODO(pkeviin): do not work
      expect(result, tUserModel);
    });
  });

  group('toJson', () {
    test('should return a valid json', () async {
      // arrange
      final user = UserModel(
        name: 'name',
        lastName: 'lastName',
        email: 'email',
        id: 1,
        mobile: 'mobile',
        token: 'token',
      );
      final user2 = UserModel(
        name: 'name2',
        lastName: 'lastName2',
        email: 'email2',
      );
      // act
      final result = user.toJson();
      final result2 = user2.toJson();
      // assert
      expect(result['name'], user.name);
      expect(result['lastName'], user.lastName);
      expect(result['email'], user.email);
      expect(result['id'], user.id);
      expect(result['mobile'], user.mobile);
      expect(result['token'], user.token);

      expect(result2['name'], user2.name);
      expect(result2['lastName'], user2.lastName);
      expect(result2['email'], user2.email);
      expect(result2['id'], null);
      expect(result2['mobile'], null);
      expect(result2['token'], null);
    });
  });
}
