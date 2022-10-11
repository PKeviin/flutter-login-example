import '../../../../../core/constants/errors_en_message_constant.dart';
import '../../../../../core/locales/generated/l10n.dart';
import '../../../../../core/providers/locale_provider.dart';
import '../../../../../core/services/api_service.dart';
import '../../../../../core/utils/errors/exceptions.dart';
import '../../../presentation/provider/user_provider.dart';
import '../../models/user_model.dart';
import 'login_remote_data_source_repository.dart';

class LoginRemoteDataSourceImpl extends ApiService
    implements LoginRemoteDataSourceRepository {
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
