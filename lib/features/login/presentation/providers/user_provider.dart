import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';

/// User provider
final userProvider =
    StateNotifierProvider<UserState, User?>((ref) => UserState());

class UserState extends StateNotifier<User?> {
  UserState() : super(null);

  /// Get the user's token
  String? get getToken => state?.session.token;

  /// Lets you know if the user is logged in
  bool get isConnected => state?.session.token != null;

  /// Get previous location
  String? get getPreviousLocation => state?.session.previousLocation;

  /// Get current location
  String? get getCurrentLocation => state?.session.currentLocation;

  /// Previous location
  /// [location] location
  void setPreviousLocation(String? location) =>
      state?.session.copyWith(previousLocation: location);

  /// Current location
  /// [location] location
  void setCurrentLocation(String? location) =>
      state?.session.copyWith(currentLocation: location);
}
