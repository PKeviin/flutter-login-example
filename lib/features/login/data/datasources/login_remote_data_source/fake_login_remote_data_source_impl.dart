import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/errors_en_message_constant.dart';
import '../../../../../core/impl/api/models/api_response_entity.dart';
import '../../../../../core/locales/generated/l10n.dart';
import '../../../../../core/utils/errors/exceptions.dart';
import '../../models/user_model.dart';
import 'login_remote_data_source_repository.dart';

final fakeLoginRemoteDataSourceImplProvider =
    Provider.autoDispose<FakeLoginRemoteDataSourceImpl>(
  (ref) => FakeLoginRemoteDataSourceImpl(),
);

class FakeLoginRemoteDataSourceImpl implements LoginRemoteDataSourceRepository {
  FakeLoginRemoteDataSourceImpl();

  @override
  Future<UserModel>? login() async {
    await Future.delayed(const Duration(seconds: 2));
    var jsonResponse = const APIJsonResponse();
    jsonResponse = jsonResponse.copyWith(error: false);
    jsonResponse = jsonResponse.copyWith(
      data: {
        'name': 'Jean',
        'lastName': 'Dupont',
        'email': 'email@gmail.com',
        'mobile': '+33684215458',
        'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE0O'
            'DA5MjkyODIsImV4cCI6MTg4MDEzMjg2OCwibmFtZSI6IlVzZXJuYW1lIn0'
            '.nRc-zT3nrUQ2vaVL5hz5kadbE3eDEOsg3eOm0ttzOio',
      },
    );

    try {
      return UserModel.fromJson(jsonResponse.data!);
    } catch (e, stacktrace) {
      throw ParseDataException(
        message: S.current.errorDataApi,
        messageEn: kErrorDataApi,
        error: e,
        stacktrace: stacktrace,
      );
    }
  }
}
