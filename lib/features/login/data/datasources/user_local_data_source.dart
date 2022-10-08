import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/constants/errors_en_message_constant.dart';
import '../../../../core/constants/secure_storage_constant.dart';
import '../../../../core/impl/secure_storage_impl.dart';
import '../../../../core/locales/generated/l10n.dart';
import '../../../../core/utils/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void>? saveUser(UserModel? user);
  Future<UserModel>? getUser();
  Future<void> removeUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl({
    required this.secureStorageImpl,
  });
  SecureStorageImpl secureStorageImpl;

  @override
  Future<UserModel>? getUser() async {
    try {
      final jsonString = await secureStorageImpl.getItem(keyCachedUser);
      if (jsonString != null) {
        final user = UserModel.fromJson(json.decode(jsonString));
        if (await _isTokenValid(user.token)) {
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
    } on FormatException catch (e, staktrace) {
      // TODO(pastork): check format exception
      throw ParseDataException(
        message: S.current.errorDataApi,
        messageEn: kErrorDataApi,
        error: e,
        stacktrace: staktrace,
      );
    } on Exception catch (e, staktrace) {
      throw CacheException(
        message: S.current.errorRetrievingUserCache,
        messageEn: kErrorRetrievingUserCache,
        error: e,
        stacktrace: staktrace,
      );
    }
  }

  @override
  Future<void>? saveUser(UserModel? user) async {
    try {
      if (user != null) {
        return await secureStorageImpl.addItem(
          keyCachedUser,
          json.encode(user.toJson()),
        );
      } else {
        throw CacheException(
          message: S.current.errorSaveUserCache,
          messageEn: kErrorSaveUserCache,
        );
      }
    } on Exception catch (e, stacktrace) {
      throw CacheException(
        message: S.current.errorSaveUserCache,
        messageEn: kErrorSaveUserCache,
        error: e,
        stacktrace: stacktrace,
      );
    }
  }

  @override
  Future removeUser() async {
    try {
      await await secureStorageImpl.removeItem(keyCachedUser);
    } on Exception catch (e, staktrace) {
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
      } on FormatException catch (e, stacktrace) {
        throw TokenException(
          message: S.current.errorFormatToken,
          messageEn: kErrorFormatToken,
          error: e,
          stacktrace: stacktrace,
        );
      } on Exception catch (e, stacktrace) {
        throw TokenException(
          message: S.current.errorSessionExpireApi,
          messageEn: kErrorSessionExpireApi,
          error: e,
          stacktrace: stacktrace,
        );
      }
    }
    return isTokenValid;
  }
}
