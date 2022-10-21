import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/impl/network_info/network_info_impl.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  NetworkInfoImpl? networkInfo;
  MockInternetConnectionChecker? mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(networkInfo: mockInternetConnectionChecker!);
  });

  group('InternetConnectionChecker', () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection (isConnected)',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);
        when(() => mockInternetConnectionChecker!.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = networkInfo!.isConnected;
        // assert
        verify(() => mockInternetConnectionChecker!.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
    test(
      'should forward the call to InternetConnectionChecker.hasConnection (isNotConnected)',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(false);
        when(() => mockInternetConnectionChecker!.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = networkInfo!.isConnected;
        // assert
        verify(() => mockInternetConnectionChecker!.hasConnection);
        expect(result, tHasConnectionFuture);
      },
    );
  });
}
