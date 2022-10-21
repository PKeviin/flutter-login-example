import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/enums/response_type_enum.dart';
import 'package:template/core/impl/api/api_http_impl.dart';
import 'package:template/core/impl/api/models/api_response_entity.dart';
import 'package:template/core/locales/generated/l10n.dart';
import 'package:template/core/utils/errors/exceptions.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  ApiHttpImpl? apiHttpImpl;
  MockHttpClient? mockHttpClient;

  const locale = 'en';
  const platform = 'android';
  const token = 'token';
  const apiUrl = 'https://api.com';

  setUp(() async {
    await S.load(const Locale.fromSubtags(languageCode: locale));
    registerFallbackValue(FakeUri());
    mockHttpClient = MockHttpClient();
    apiHttpImpl = ApiHttpImpl(
      client: mockHttpClient!,
      token: token,
      locale: locale,
      platform: platform,
      apiUrl: apiUrl,
    );
  });

  const tDataType = ResponseDataTypeEnum.json;
  const tRoute = '/route';

  group('Api Http', () {
    test('should return a valid header', () {
      // act
      final result = apiHttpImpl!.getHeaders;
      // assert
      expect(result, {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'x-lang': locale,
        'x-app': platform,
        HttpHeaders.contentTypeHeader: 'application/json',
      });
    });

    group('get', () {
      void setUpMockHttpClientSuccessGet(String data) {
        final tResponseSucess = http.Response(data, 200);
        when(
          () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => tResponseSucess);
      }

      void setUpMockHttpClientUnsuccessGet(int statusCode, String data) {
        final tResponseUnsucess = http.Response(data, statusCode);
        when(
          () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
        ).thenAnswer((_) async => tResponseUnsucess);
      }

      group('success', () {
        test(
          'should return APIJsonResponse when the response code is 200 (success)',
          () async {
            // arrange
            const tError = false;
            const tUnauthorized = false;
            const tData = '{"title": "Test"}';
            setUpMockHttpClientSuccessGet(tData);
            // act
            final result = await apiHttpImpl!.get(
              route: tRoute,
              dataType: tDataType,
              queryParams: {'test': 'test'},
            );
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<APIJsonResponse>());
            expect(result.statusCode, 200);
            expect(result.unauthorized, tUnauthorized);
            expect(result.error, tError);
            expect(result.data, json.decode(tData));
          },
        );
      });

      group('error', () {
        test(
          'should return ParseDataException when the response (code : 200) body is not a valid json',
          () async {
            // arrange
            final tErrorMessage = S.current.errorDataApi;
            const tData = '{"title": {} "Test"}';
            setUpMockHttpClientSuccessGet(tData);
            // act
            ParseDataException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ParseDataException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ParseDataException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return CertificatException when the http return HandshakeException',
          () async {
            // arrange
            final tErrorMessage = S.current.errorCertificatServerApi;
            const tException = HandshakeException('HandshakeException');
            when(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            ).thenThrow(tException);
            // act
            CertificatException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as CertificatException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<CertificatException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return CertificatException when the http return CertificateException',
          () async {
            // arrange
            final tErrorMessage = S.current.errorVerificationCertificatApi;
            const tException = CertificateException('CertificateException');
            when(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            ).thenThrow(tException);
            // act
            CertificatException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as CertificatException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<CertificatException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the http return ClientException / Exception',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            final tException = ClientException('ClientException');
            when(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            ).thenThrow(tException);
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 404 (not found) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 404 not found message';
            const tStatusCode = 404;
            setUpMockHttpClientUnsuccessGet(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 404 (not found) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApiNotFound;
            const tStatusCode = 404;
            setUpMockHttpClientUnsuccessGet(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 400 (badRequest) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'errors 400 badRequest message';
            const tStatusCode = 400;
            setUpMockHttpClientUnsuccessGet(
              tStatusCode,
              '{"errors": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 400 (badRequest) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorBadRequestApi;
            const tStatusCode = 400;
            setUpMockHttpClientUnsuccessGet(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 401 (unauthorized) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 401 unauthorized message';
            const tStatusCode = 401;
            setUpMockHttpClientUnsuccessGet(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 401 (unauthorized) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApiUnauthorized;
            const tStatusCode = 401;
            setUpMockHttpClientUnsuccessGet(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 403 (forbidden) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 403 forbidden message';
            const tStatusCode = 403;
            setUpMockHttpClientUnsuccessGet(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 403 (forbidden) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorSessionExpireApi;
            const tStatusCode = 403;
            setUpMockHttpClientUnsuccessGet(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 409 (conflict) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 409 conflict message';
            const tStatusCode = 409;
            setUpMockHttpClientUnsuccessGet(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 409 (conflict) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            const tStatusCode = 409;
            setUpMockHttpClientUnsuccessGet(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 500 (internalServerError) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorServerApi;
            const tStatusCode = 500;
            setUpMockHttpClientUnsuccessGet(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response is error (switch case default) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            const tStatusCode = 505;
            setUpMockHttpClientUnsuccessGet(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.get(route: tRoute, dataType: tDataType);
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.get(any(), headers: any(named: 'headers')),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );
      });
    });

    group('post', () {
      void _setUpMockHttpClientSuccessPost(String data) {
        final tResponseSucess = http.Response(data, 200);
        when(
          () => mockHttpClient!.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => tResponseSucess);
      }

      void _setUpMockHttpClientUnsuccessPost(int statusCode, String data) {
        final tResponseUnsucess = http.Response(data, statusCode);
        when(
          () => mockHttpClient!.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => tResponseUnsucess);
      }

      group('success', () {
        test(
          'should return APIJsonResponse when the response code is 200 (success)',
          () async {
            // arrange
            const tError = false;
            const tUnauthorized = false;
            const tData = '{"title": "test"}';
            _setUpMockHttpClientSuccessPost(tData);
            // act
            final result = await apiHttpImpl!.post(
              route: tRoute,
              body: {'test': 'test'},
            );
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<APIJsonResponse>());
            expect(result.statusCode, 200);
            expect(result.unauthorized, tUnauthorized);
            expect(result.error, tError);
            expect(result.data, json.decode(tData));
          },
        );
      });

      group('error', () {
        test(
          'should return ParseDataException when the response (code : 200) body is not a valid json',
          () async {
            // arrange
            final tErrorMessage = S.current.errorDataApi;
            const tData = '{"title": {} "test"}';
            _setUpMockHttpClientSuccessPost(tData);
            // act
            ParseDataException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ParseDataException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ParseDataException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return CertificatException when the http return HandshakeException',
          () async {
            // arrange
            final tErrorMessage = S.current.errorCertificatServerApi;
            const tException = HandshakeException('HandshakeException');
            when(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            ).thenThrow(tException);
            // act
            CertificatException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as CertificatException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<CertificatException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return CertificatException when the http return CertificateException',
          () async {
            // arrange
            final tErrorMessage = S.current.errorVerificationCertificatApi;
            const tException = CertificateException('CertificateException');
            when(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            ).thenThrow(tException);
            // act
            CertificatException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as CertificatException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<CertificatException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the http return ClientException / Exception',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            final tException = ClientException('ClientException');
            when(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            ).thenThrow(tException);
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 404 (not found) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 404 not found message';
            const tStatusCode = 404;
            _setUpMockHttpClientUnsuccessPost(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 404 (not found) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApiNotFound;
            const tStatusCode = 404;
            _setUpMockHttpClientUnsuccessPost(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 400 (badRequest) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'errors 400 badRequest message';
            const tStatusCode = 400;
            _setUpMockHttpClientUnsuccessPost(
              tStatusCode,
              '{"errors": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 400 (badRequest) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorBadRequestApi;
            const tStatusCode = 400;
            _setUpMockHttpClientUnsuccessPost(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 401 (unauthorized) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 401 unauthorized message';
            const tStatusCode = 401;
            _setUpMockHttpClientUnsuccessPost(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 401 (unauthorized) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApiUnauthorized;
            const tStatusCode = 401;
            _setUpMockHttpClientUnsuccessPost(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 403 (forbidden) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 403 forbidden message';
            const tStatusCode = 403;
            _setUpMockHttpClientUnsuccessPost(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 403 (forbidden) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorSessionExpireApi;
            const tStatusCode = 403;
            _setUpMockHttpClientUnsuccessPost(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 409 (conflict) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 409 conflict message';
            const tStatusCode = 409;
            _setUpMockHttpClientUnsuccessPost(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 409 (conflict) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            const tStatusCode = 409;
            _setUpMockHttpClientUnsuccessPost(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 500 (internalServerError) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorServerApi;
            const tStatusCode = 500;
            _setUpMockHttpClientUnsuccessPost(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response is error (switch case default) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            const tStatusCode = 505;
            _setUpMockHttpClientUnsuccessPost(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.post(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );
      });
    });

    group('put', () {
      void _setUpMockHttpClientSuccessPut(String data) {
        final tResponseSucess = http.Response(data, 200);
        when(
          () => mockHttpClient!.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => tResponseSucess);
      }

      void _setUpMockHttpClientUnsuccessPut(int statusCode, String data) {
        final tResponseUnsucess = http.Response(data, statusCode);
        when(
          () => mockHttpClient!.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => tResponseUnsucess);
      }

      group('success', () {
        test(
          'should return APIJsonResponse when the response code is 200 (success)',
          () async {
            // arrange
            const tError = false;
            const tUnauthorized = false;
            const tData = '{"title": "Test"}';
            _setUpMockHttpClientSuccessPut(tData);
            // act
            final result = await apiHttpImpl!.put(
              route: tRoute,
              body: {'test': 'test'},
            );
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<APIJsonResponse>());
            expect(result.statusCode, 200);
            expect(result.unauthorized, tUnauthorized);
            expect(result.error, tError);
            expect(result.data, json.decode(tData));
          },
        );
      });

      group('error', () {
        test(
          'should return ParseDataException when the response (code : 200) body is not a valid json',
          () async {
            // arrange
            final tErrorMessage = S.current.errorDataApi;
            const tData = '{"title": { : } "Test"}';
            _setUpMockHttpClientSuccessPut(tData);
            // act
            ParseDataException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ParseDataException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ParseDataException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return CertificatException when the http return HandshakeException',
          () async {
            // arrange
            final tErrorMessage = S.current.errorCertificatServerApi;
            const tException = HandshakeException('HandshakeException');
            when(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            ).thenThrow(tException);
            // act
            CertificatException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as CertificatException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<CertificatException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return CertificatException when the http return CertificateException',
          () async {
            // arrange
            final tErrorMessage = S.current.errorVerificationCertificatApi;
            const tException = CertificateException('CertificateException');
            when(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            ).thenThrow(tException);
            // act
            CertificatException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as CertificatException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<CertificatException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the http return ClientException / Exception',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            final tException = ClientException('ClientException');
            when(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            ).thenThrow(tException);
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 404 (not found) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 404 not found message';
            const tStatusCode = 404;
            _setUpMockHttpClientUnsuccessPut(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 404 (not found) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApiNotFound;
            const tStatusCode = 404;
            _setUpMockHttpClientUnsuccessPut(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 400 (badRequest) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'errors 400 badRequest message';
            const tStatusCode = 400;
            _setUpMockHttpClientUnsuccessPut(
              tStatusCode,
              '{"errors": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 400 (badRequest) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorBadRequestApi;
            const tStatusCode = 400;
            _setUpMockHttpClientUnsuccessPut(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 401 (unauthorized) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 401 unauthorized message';
            const tStatusCode = 401;
            _setUpMockHttpClientUnsuccessPut(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 401 (unauthorized) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApiUnauthorized;
            const tStatusCode = 401;
            _setUpMockHttpClientUnsuccessPut(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 403 (forbidden) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 403 forbidden message';
            const tStatusCode = 403;
            _setUpMockHttpClientUnsuccessPut(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 403 (forbidden) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorSessionExpireApi;
            const tStatusCode = 403;
            _setUpMockHttpClientUnsuccessPut(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 409 (conflict) '
          'error message sent by the server',
          () async {
            // arrange
            const tErrorMessage = 'error 409 conflict message';
            const tStatusCode = 409;
            _setUpMockHttpClientUnsuccessPut(
              tStatusCode,
              '{"error": "$tErrorMessage"}',
            );
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 409 (conflict) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            const tStatusCode = 409;
            _setUpMockHttpClientUnsuccessPut(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response code is 500 (internalServerError) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorServerApi;
            const tStatusCode = 500;
            _setUpMockHttpClientUnsuccessPut(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );

        test(
          'should return ServerException when the response is error (switch case default) '
          'error message not sent by the server',
          () async {
            // arrange
            final tErrorMessage = S.current.errorApi;
            const tStatusCode = 505;
            _setUpMockHttpClientUnsuccessPut(tStatusCode, '{}');
            // act
            ServerException? result;
            try {
              await apiHttpImpl!.put(
                route: tRoute,
                body: {'test': 'test'},
              );
            } catch (e) {
              result = e as ServerException;
            }
            // assert
            verify(
              () => mockHttpClient!.put(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            );
            expect(result, isInstanceOf<ServerException>());
            expect(result!.statusCode, tStatusCode);
            expect(result.message, tErrorMessage);
            expect(result.messageEn, tErrorMessage);
          },
        );
      });
    });
  });
}
