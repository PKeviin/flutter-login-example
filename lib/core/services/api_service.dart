import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../features/login/presentation/provider/user_provider.dart';
import '../constants/errors_en_message_constant.dart';
import '../credentials.dart';
import '../enums/response_type_enum.dart';
import '../locales/generated/l10n.dart';
import '../providers/locale_provider.dart';
import '../utils/errors/exceptions.dart';
import '../utils/utils.dart';
import 'models/api_response_entity.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) => ApiService(
    ref.watch(userProvider.notifier),
    ref.watch(localeProvider.notifier),
  ),
);

class ApiService {
  ApiService(this._userState, this._localeState);
  final UserState _userState;
  final LocaleState _localeState;

  String api = Credential.apiBase;
  Map<String, String> headers = {
    'x-app': Utils.getPlatform(),
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  /// Init header
  void _setHeaders() {
    final userJWT = _userState.getToken;
    if (userJWT != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $userJWT';
    }
    headers['x-lang'] = _localeState.getLanguageCode;
  }

  /// POST
  /// [route] route
  /// [body] dara
  Future<APIJsonResponse> post({
    required String route,
    Map<String, dynamic>? body,
    ResponseDataTypeEnum dataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      _setHeaders();
      final request = http.post(
        Uri.parse('$api$route'),
        headers: headers,
        body: body != null ? utf8.encode(jsonEncode(body)) : null,
      );

      return request
          .then((response) async => _getAPIJsonResponse(response, dataType));
    } on Exception catch (e, stacktrace) {
      if (e is HandshakeException || e is CertificateException) {
        return _certificatException(e);
      } else {
        throw UnknownException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          error: e,
          stacktrace: stacktrace,
        );
      }
    }
  }

  /// POST UPLOAD FILES
  /// [route] route
  /// [formData] file list
  Future<APIJsonResponse> postWithFiles({
    required String route,
    required FormData formData,
    ResponseDataTypeEnum dataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      final dio = Dio(
        BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: 60 * 1000,
          headers: {
            'Authorization': 'Bearer ${_userState.getToken}',
          },
        ),
      );

      final response = await dio.post(
        '$api$route',
        data: formData,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status == HttpStatus.ok,
        ),
      );

      return _getAPIJsonResponse(response, dataType);
    } on Exception catch (e, stacktrace) {
      if (e is HandshakeException || e is CertificateException) {
        return _certificatException(e);
      } else {
        throw UnknownException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          error: e,
          stacktrace: stacktrace,
        );
      }
    }
  }

  /// PUT
  /// [route] route
  /// [body] data
  Future<APIJsonResponse> put({
    required String route,
    Map<String, dynamic>? body,
    ResponseDataTypeEnum dataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      _setHeaders();
      final request = http.put(
        Uri.parse('$api$route'),
        headers: headers,
        body: body != null ? utf8.encode(jsonEncode(body)) : null,
      );

      return request
          .then((response) async => _getAPIJsonResponse(response, dataType));
    } on Exception catch (e, stacktrace) {
      if (e is HandshakeException || e is CertificateException) {
        return _certificatException(e);
      } else {
        throw UnknownException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          error: e,
          stacktrace: stacktrace,
        );
      }
    }
  }

  /// GET
  /// [route] route
  /// [queryParams] params
  Future<APIJsonResponse> get({
    required String route,
    required ResponseDataTypeEnum dataType,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      _setHeaders();
      Map<String, dynamic>? parsedQuery;
      if (queryParams != null) {
        parsedQuery =
            queryParams.map((key, value) => MapEntry(key, value.toString()));
      }
      final queryString = parsedQuery != null
          ? '?${Uri(queryParameters: parsedQuery).query}'
          : '';

      final request = http.get(
        Uri.parse('$api$route$queryString'),
        headers: headers,
      );

      return request
          .then((response) async => _getAPIJsonResponse(response, dataType));
    } on Exception catch (e, stacktrace) {
      if (e is HandshakeException || e is CertificateException) {
        return _certificatException(e);
      } else {
        throw UnknownException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          error: e,
          stacktrace: stacktrace,
        );
      }
    }
  }

  /// Catch a certificate error
  Future<APIJsonResponse> _certificatException(Object e) async {
    if (e is HandshakeException) {
      throw CertificatException(
        message: S.current.errorCertificatServerApi,
        messageEn: kErrorCertificatServerApi,
      );
    } else {
      throw CertificatException(
        message: S.current.errorVerificationCertificatApi,
        messageEn: kErrorVerificationCertificatApi,
      );
    }
  }

  /// Response retrieval
  Future<APIJsonResponse> _getAPIJsonResponse(
    response,
    ResponseDataTypeEnum dataType,
  ) async {
    dynamic data;
    try {
      switch (dataType) {
        case ResponseDataTypeEnum.json:
          data = json.decode(response.body);
          break;
        case ResponseDataTypeEnum.bytes:
          data = response;
          break;
        case ResponseDataTypeEnum.string:
          data = await response.transform(utf8.decoder).join();
          break;
        case ResponseDataTypeEnum.stream:
          break;
        case ResponseDataTypeEnum.plain:
          break;
      }
    } on Exception catch (e, stacktrace) {
      throw ParseDataException(
        message: S.current.errorDataApi,
        messageEn: kErrorDataApi,
        error: e,
        stacktrace: stacktrace,
      );
    }

    String? error;
    String? errors;
    String? result;
    try {
      if (response.statusCode != HttpStatus.ok &&
          response.statusCode != HttpStatus.created &&
          response.statusCode != HttpStatus.accepted) {
        // To be modified according to the API
        errors = data?['errors']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', '') ??
            data['error'].toString();
        error = data['error'];
        result = data['result'];
      }
    } on Exception catch (e, stacktrace) {
      await Utils.traceLogError(kErrorDataApi, e, stacktrace);
    }

    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.created:
      case HttpStatus.accepted:
        return APIJsonResponse(
          data: data ?? true,
          statusCode: response.statusCode,
        );
      case HttpStatus.badRequest:
        throw ServerException(
          message: errors != null && errors.isNotEmpty
              ? errors
              : S.current.errorBadRequestApi,
          messageEn: errors != null && errors.isNotEmpty
              ? errors
              : kErrorBadRequestApi,
          statutCode: response.statusCode,
        );
      case HttpStatus.unauthorized:
      case HttpStatus.forbidden:
        if (result != null) {
          await _userState.reconnect();
          throw ServerException(
            message: S.current.errorSessionExpireApi,
            messageEn: kErrorSessionExpireApi,
            statutCode: response.statusCode,
          );
        } else {
          throw ServerException(
            message: S.current.errorApiUnauthorized,
            messageEn: kErrorApiUnauthorized,
            statutCode: response.statusCode,
          );
        }
      case HttpStatus.notFound:
        throw ServerException(
          message: error ?? S.current.errorApiNotFound,
          messageEn: error ?? kErrorApiNotFound,
          statutCode: response.statusCode,
        );
      case HttpStatus.conflict:
        throw ServerException(
          message: error ?? S.current.errorApi,
          messageEn: error ?? kErrorApi,
          statutCode: response.statusCode,
        );
      case HttpStatus.internalServerError:
        throw ServerException(
          message: S.current.errorServerApi,
          messageEn: kErrorServerApi,
          statutCode: response.statusCode,
        );
      default:
        throw ServerException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          statutCode: response.statusCode,
        );
    }
  }
}
