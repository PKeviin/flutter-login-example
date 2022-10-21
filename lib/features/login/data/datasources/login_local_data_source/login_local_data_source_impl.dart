import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../../core/constants/errors_en_message_constant.dart';
import '../../../../../core/constants/secure_storage_constant.dart';
import '../../../../../core/impl/secure_storage/secure_storage_repository.dart';
import '../../../../../core/locales/generated/l10n.dart';
import '../../../../../core/utils/errors/exceptions.dart';
import '../../models/user_model.dart';
import 'login_local_data_source_repository.dart';

class LoginLocalDataSourceImpl implements LoginLocalDataSourceRepository {
  LoginLocalDataSourceImpl({
    required this.secureStorage,
  });
  SecureStorageRepository secureStorage;

  @override
  Future<UserModel> getUser() async {
    try {
      final jsonString = await secureStorage.getItem(keyCachedUser);
      if (jsonString != null) {
        final user = UserModel.fromJson(json.decode(jsonString));
        if (await _isTokenValid(user.session.token)) {
          return user;
        } else {
          throw TokenException(
            message: S.current.errorSessionExpireApi,
            messageEn: kErrorSessionExpireApi,
          );
        }
      } else {
        throw CacheException(
          message: S.current.errorRetrievingUserCache,
          messageEn: kErrorRetrievingUserCache,
        );
      }
    } on TokenException catch (e, stacktrace) {
      throw TokenException(
        message: S.current.errorSessionExpireApi,
        messageEn: kErrorSessionExpireApi,
        error: e,
        stacktrace: stacktrace,
      );
    } catch (e, staktrace) {
      throw CacheException(
        message: S.current.errorRetrievingUserCache,
        messageEn: kErrorRetrievingUserCache,
        error: e,
        stacktrace: staktrace,
      );
    }
  }

  @override
  Future<void> cacheUser(UserModel? user) async {
    try {
      if (user != null) {
        return await secureStorage.addItem(
          keyCachedUser,
          json.encode(user.toJson()),
        );
      } else {
        throw CacheException(
          message: S.current.errorSaveUserCache,
          messageEn: kErrorSaveUserCache,
        );
      }
    } catch (e, stacktrace) {
      throw CacheException(
        message: S.current.errorSaveUserCache,
        messageEn: kErrorSaveUserCache,
        error: e,
        stacktrace: stacktrace,
      );
    }
  }

  @override
  Future<void> removeUser() async {
    try {
      await await secureStorage.removeItem(keyCachedUser);
    } catch (e, staktrace) {
      throw CacheException(
        message: S.current.errorRetrievingUserCache,
        messageEn: kErrorRetrievingUserCache,
        error: e,
        stacktrace: staktrace,
      );
    }
  }

  /// Allows to know if the user has a valid token
  Future<bool> _isTokenValid(String? token) async {
    var isTokenValid = false;
    if (token != null) {
      try {
        isTokenValid = !JwtDecoder.isExpired(token);
      } catch (e, stacktrace) {
        throw TokenException(
          message: S.current.errorFormatToken,
          messageEn: kErrorFormatToken,
          error: e,
          stacktrace: stacktrace,
        );
      }
    }
    return isTokenValid;
  }
}
