import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_info_repository.dart';

class NetworkInfoImpl implements NetworkInfoRepository {
  NetworkInfoImpl({
    required this.networkInfo,
  });
  InternetConnectionChecker networkInfo;

  /// Checks if the phone is connected to the internet
  @override
  Future<bool> get isConnected => networkInfo.hasConnection;
}
