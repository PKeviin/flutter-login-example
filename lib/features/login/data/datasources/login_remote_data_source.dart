import '../../../../core/constants/errors_en_message_constant.dart';
import '../../../../core/locales/generated/l10n.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/models/api_response_entity.dart';
import '../../../../core/utils/errors/exceptions.dart';
import '../../presentation/provider/user_provider.dart';
import '../models/user_model.dart';

//ignore: one_member_abstracts
abstract class LoginRemoteDataSource {
  Future<UserModel>? login();
}

class LoginRemoteDataSourceImpl extends ApiService
    implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl({
    required UserState userState,
    required LocaleState localeState,
    required this.identifiant,
    required this.password,
  }) : super(userState, localeState);
  final String identifiant;
  final String password;

  @override
  Future<UserModel>? login() async {
    final jsonResponse = await post(
      route: '/user/login',
      body: {
        'username': identifiant,
        'password': password,
      },
    );

    try {
      return UserModel.fromJson(jsonResponse.data!);
    } on Exception catch (e, stacktrace) {
      throw ParseDataException(
        message: S.current.errorDataApi,
        messageEn: kErrorDataApi,
        error: e,
        stacktrace: stacktrace,
      );
    }
  }
}

class FakeLoginRemoteDataSourceImpl extends ApiService
    implements LoginRemoteDataSource {
  FakeLoginRemoteDataSourceImpl({
    required UserState userState,
    required LocaleState localeState,
    required this.identifiant,
    required this.password,
  }) : super(userState, localeState);
  final String identifiant;
  final String password;

  @override
  Future<UserModel>? login() async {
    await Future.delayed(const Duration(seconds: 2));
    // FAKE DATA
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
    } on Exception catch (e, stacktrace) {
      throw ParseDataException(
        message: S.current.errorDataApi,
        messageEn: kErrorDataApi,
        error: e,
        stacktrace: stacktrace,
      );
    }
  }
}
