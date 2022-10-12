import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/errors_en_message_constant.dart';
import '../../../../../core/impl/api/api_http_provider.dart';
import '../../../../../core/impl/api/api_repository.dart';
import '../../../../../core/locales/generated/l10n.dart';
import '../../../../../core/utils/errors/exceptions.dart';
import '../../../presentation/provider/login_provider.dart';
import '../../models/user_model.dart';
import 'login_remote_data_source_repository.dart';

final loginRemoteDataSourceImplProvider =
    Provider.autoDispose<LoginRemoteDataSourceImpl>((ref) {
  final api = ref.watch(apiHttpImplProvider);
  final identifiant = ref.watch(identifiantProvider);
  final password = ref.watch(passwordProvider);
  return LoginRemoteDataSourceImpl(
    api: api,
    password: password,
    identifiant: identifiant,
  );
});

class LoginRemoteDataSourceImpl implements LoginRemoteDataSourceRepository {
  LoginRemoteDataSourceImpl({
    required this.api,
    required this.identifiant,
    required this.password,
  });
  final ApiRepository api;
  final String identifiant;
  final String password;

  @override
  Future<UserModel>? login() async {
    final jsonResponse = await api.post(
      route: '/user/login',
      body: {
        'username': identifiant,
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
