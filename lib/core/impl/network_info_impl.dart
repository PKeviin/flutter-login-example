import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// NetworkInfo provider
final networkInfoProvider =
    Provider<NetworkInfoImpl>((ref) => NetworkInfoImpl());

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  /// Checks if the phone is connected to the internet
  @override
  Future<bool> get isConnected => InternetConnectionChecker().hasConnection;
}
