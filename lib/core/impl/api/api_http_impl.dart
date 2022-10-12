import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../features/login/presentation/provider/user_provider.dart';
import '../../constants/errors_en_message_constant.dart';
import '../../credentials.dart';
import '../../enums/response_type_enum.dart';
import '../../locales/generated/l10n.dart';
import '../../providers/locale_provider.dart';
import '../../utils/errors/exceptions.dart';
import '../../utils/extensions/string_extension.dart';
import '../logger/logger_repository.dart';
import 'api_repository.dart';
import 'models/api_response_entity.dart';

class ApiHttpImpl implements ApiRepository {
  ApiHttpImpl({
    required this.logger,
    required this.localeState,
    required this.platform,
    this.userState,
  });
  final LoggerRepository logger;
  final LocaleState localeState;
  final String platform;
  final UserState? userState;

  final String _api = Credential.apiBase;
  final Map<String, String> _headers = {};

  /// Init header
  void _initHeaders() {
    final userJWT = userState?.getToken;
    if (userJWT != null) {
      _headers[HttpHeaders.authorizationHeader] = 'Bearer $userJWT';
    }
    _headers['x-lang'] = localeState.getLanguageCode;
    _headers['x-app'] = platform;
    _headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  /// POST
  /// [route] route
  /// [body] dara
  @override
  Future<APIJsonResponse> post({
    required String route,
    Map<String, dynamic>? body,
    ResponseDataTypeEnum dataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      _initHeaders();
      final request = http.post(
        Uri.parse('$_api$route'),
        headers: _headers,
        body: body != null ? utf8.encode(jsonEncode(body)) : null,
      );

      return request.then(
        (response) async => _getAPIResponse(
          dataType: dataType,
          response: response,
        ),
      );
    } catch (e, stacktrace) {
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
  @override
  Future<APIJsonResponse> put({
    required String route,
    Map<String, dynamic>? body,
    ResponseDataTypeEnum dataType = ResponseDataTypeEnum.json,
  }) async {
    try {
      _initHeaders();
      final request = http.put(
        Uri.parse('$_api$route'),
        headers: _headers,
        body: body != null ? utf8.encode(jsonEncode(body)) : null,
      );

      return request.then(
        (response) async => _getAPIResponse(
          dataType: dataType,
          response: response,
        ),
      );
    } catch (e, stacktrace) {
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
  @override
  Future<APIJsonResponse> get({
    required String route,
    required ResponseDataTypeEnum dataType,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      _initHeaders();
      Map<String, dynamic>? parsedQuery;
      if (queryParams != null) {
        parsedQuery =
            queryParams.map((key, value) => MapEntry(key, value.toString()));
      }
      final queryString = parsedQuery != null
          ? '?${Uri(queryParameters: parsedQuery).query}'
          : '';

      final request = http.get(
        Uri.parse('$_api$route$queryString'),
        headers: _headers,
      );

      return request.then(
        (response) async => _getAPIResponse(
          dataType: dataType,
          response: response,
        ),
      );
    } catch (e, stacktrace) {
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
  Future<APIJsonResponse> _getAPIResponse({
    required ResponseDataTypeEnum dataType,
    required http.Response response,
  }) async {
    dynamic data;
    try {
      switch (dataType) {
        case ResponseDataTypeEnum.json:
          data = json.decode(response.body);
          break;
        case ResponseDataTypeEnum.bytes:
        case ResponseDataTypeEnum.string:
        case ResponseDataTypeEnum.stream:
        case ResponseDataTypeEnum.plain:
          break;
      }
    } catch (e, stacktrace) {
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
        if (data is Map<String, dynamic>) {
          if (data['errors'].toString().isNotNullOrEmpty()) {
            errors = data['errors']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', '');
          }
          if (data['error'].toString().isNotNullOrEmpty()) {
            error = data['error'].toString();
          }
          if (data['result'].toString().isNotNullOrEmpty()) {
            result = data['result'];
          }
        }
      }
    } catch (e, stacktrace) {
      await logger.traceLogError(
        message: kErrorDataApi,
        error: e,
        stacktrace: stacktrace,
      );
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
          // TODO(KeviinP): delete ?
          // await _userState?.reconnect();
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
