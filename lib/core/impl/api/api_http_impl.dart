import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../constants/errors_en_message_constant.dart';
import '../../enums/response_type_enum.dart';
import '../../locales/generated/l10n.dart';
import '../../utils/errors/exceptions.dart';
import '../../utils/extensions/string_extension.dart';
import 'api_repository.dart';
import 'models/api_response_entity.dart';

class ApiHttpImpl implements ApiRepository {
  ApiHttpImpl({
    required this.client,
    required this.locale,
    required this.platform,
    required this.apiUrl,
    this.token,
  });
  final http.Client client;
  final String locale;
  final String platform;
  final String apiUrl;
  final String? token;

  /// Init header
  Map<String, String> get getHeaders {
    final headers = <String, String>{};
    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    headers['x-lang'] = locale;
    headers['x-app'] = platform;
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    return headers;
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
      final request = client.post(
        Uri.parse('$apiUrl$route'),
        headers: getHeaders,
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
        throw ServerException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          error: e,
          stacktrace: stacktrace,
          statusCode: -1,
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
      final request = client.put(
        Uri.parse('$apiUrl$route'),
        headers: getHeaders,
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
        throw ServerException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          error: e,
          stacktrace: stacktrace,
          statusCode: -1,
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
      Map<String, dynamic>? parsedQuery;
      if (queryParams != null) {
        parsedQuery =
            queryParams.map((key, value) => MapEntry(key, value.toString()));
      }
      final queryString = parsedQuery != null
          ? '?${Uri(queryParameters: parsedQuery).query}'
          : '';

      final request = client.get(
        Uri.parse('$apiUrl$route$queryString'),
        headers: getHeaders,
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
        throw ServerException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          error: e,
          stacktrace: stacktrace,
          statusCode: -1,
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
        // coverage:ignore-start
        case ResponseDataTypeEnum.bytes:
        case ResponseDataTypeEnum.string:
        case ResponseDataTypeEnum.stream:
        case ResponseDataTypeEnum.plain:
          break;
        // coverage:ignore-end
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
    // ignore: unused_local_variable
    String? result;
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created &&
        response.statusCode != HttpStatus.accepted) {
      // To be modified according to the API
      if (data is Map<String, dynamic>) {
        error = data['error'] as String?;
        result = data['result'] as String?;
        errors = data['errors'] as String?;
        if (errors.isNotNullOrEmpty()) {
          errors = errors
              ?.replaceAll('{', '')
              .replaceAll('}', '')
              .replaceAll('[', '')
              .replaceAll(']', '');
        }
      }
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
          statusCode: response.statusCode,
        );
      case HttpStatus.unauthorized:
        throw ServerException(
          message: error ?? S.current.errorApiUnauthorized,
          messageEn: error ?? kErrorApiUnauthorized,
          statusCode: response.statusCode,
        );
      case HttpStatus.forbidden:
        // TODO(KeviinP): delete ?
        // await _userState?.reconnect();
        throw ServerException(
          message: error ?? S.current.errorSessionExpireApi,
          messageEn: error ?? kErrorSessionExpireApi,
          statusCode: response.statusCode,
        );
      case HttpStatus.notFound:
        throw ServerException(
          message: error ?? S.current.errorApiNotFound,
          messageEn: error ?? kErrorApiNotFound,
          statusCode: response.statusCode,
        );
      case HttpStatus.conflict:
        throw ServerException(
          message: error ?? S.current.errorApi,
          messageEn: error ?? kErrorApi,
          statusCode: response.statusCode,
        );
      case HttpStatus.internalServerError:
        throw ServerException(
          message: S.current.errorServerApi,
          messageEn: kErrorServerApi,
          statusCode: response.statusCode,
        );
      default:
        throw ServerException(
          message: S.current.errorApi,
          messageEn: kErrorApi,
          statusCode: response.statusCode,
        );
    }
  }
}
