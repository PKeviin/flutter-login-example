import '../../../../../core/constants/errors_en_message_constant.dart';
import '../../../../../core/impl/api/api_repository.dart';
import '../../../../../core/locales/generated/l10n.dart';
import '../../../../../core/utils/errors/exceptions.dart';
import '../../models/user_model.dart';
import 'login_remote_data_source_repository.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSourceRepository {
  LoginRemoteDataSourceImpl({
    required this.api,
    required this.username,
    required this.password,
  });
  final ApiRepository api;
  final String username;
  final String password;

  @override
  Future<UserModel>? login() async {
    final jsonResponse = await api.post(
      route: '/user/login',
      body: {
        'username': username,
        'password': password,
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
