import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/impl/local_auth_impl.dart';
import '../../../../core/impl/network_info_impl.dart';
import '../../../../core/impl/secure_storage_impl.dart';
import '../../../../core/providers/failure_provider.dart';
import '../../../../core/providers/loader_provider.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/datasources/login_remote_data_source.dart';
import '../../data/datasources/user_local_data_source.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../data/repositories/logout_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';

/// User entity provider
final userProvider = StateNotifierProvider<UserState, UserEntity?>((ref) {
  final localeState = ref.watch(localeProvider.notifier);
  final failureState = ref.watch(failureProvider.notifier);
  final loaderState = ref.watch(loaderProvider.notifier);
  final secureStorage = ref.watch(secureStorageProvider);
  final localAuth = ref.watch(localAuthProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return UserState(
    localeState: localeState,
    failureState: failureState,
    loaderState: loaderState,
    localAuthImpl: localAuth,
    secureStorageImpl: secureStorage,
    networkInfoImpl: networkInfo,
  );
});

class UserState extends StateNotifier<UserEntity?> {
  UserState({
    required this.localeState,
    required this.loaderState,
    required this.failureState,
    required this.localAuthImpl,
    required this.secureStorageImpl,
    required this.networkInfoImpl,
  }) : super(null) {
    unawaited(_eitherFailureOrLoginLocaleUser());
  }
  LocaleState localeState;
  FailureProviderState failureState;
  LoaderProviderState loaderState;
  LocalAuthImpl localAuthImpl;
  SecureStorageImpl secureStorageImpl;
  NetworkInfoImpl networkInfoImpl;

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

  /// Init user locale session
  Future<void> _eitherFailureOrLoginLocaleUser() async {
    final repository = LoginRepositoryImpl.locale(
      localDataSource: UserLocalDataSourceImpl(
        secureStorageImpl: secureStorageImpl,
      ),
    );

    final failureOrUser =
        await LoginUser(repository).loginLocaleUser(NoParams());

    await failureOrUser?.fold(
      (newFailure) {
        state = null;
        // Disabling user fetch error in cache
        // The error may be triggered each time the app is launched even
        // if it is the first start
        // failureState.state = newFailure;
      },
      (user) async {
        final hasBiometrics = await localAuthImpl.hasBiometrics;
        if (!hasBiometrics ||
            (hasBiometrics && await localAuthImpl.hasLocalAuthenticate)) {
          state = user;
          failureState.state = null;
        }
      },
    );
  }

  /// User Login
  Future<void> eitherFailureOrLoginUser(
    String identifiant,
    String password,
  ) async {
    loaderState.state = true;
    final repository = LoginRepositoryImpl(
      // Implementation of a fake login
      // Using LoginRemoteDataSourceImpl to implement real login
      remoteDataSource: FakeLoginRemoteDataSourceImpl(
        identifiant: identifiant,
        password: password,
        userState: this,
        localeState: localeState,
      ),
      localDataSource: UserLocalDataSourceImpl(
        secureStorageImpl: secureStorageImpl,
      ),
      networkInfo: networkInfoImpl,
    );

    final failureOrUser = await LoginUser(repository).loginUser(NoParams());

    failureOrUser?.fold(
      (newFailure) {
        state = null;
        failureState.state = newFailure;
      },
      (user) {
        state = user;
        failureState.state = null;
      },
    );
    loaderState.state = false;
  }

  /// Logout user
  Future<void> logout() async {
    loaderState.state = true;
    final repository = LogoutRepositoryImpl(
      localDataSource: UserLocalDataSourceImpl(
        secureStorageImpl: secureStorageImpl,
      ),
    );

    final failureOrSession =
        await LogoutUser(repository).logoutUser(NoParams());

    failureOrSession?.fold(
      (newFailure) {
        failureState.state = newFailure;
      },
      (isOk) {
        state = null;
      },
    );
    loaderState.state = false;
  }

  /// User re-authentication request
  Future<void> reconnect({bool showDialog = true}) async {
    await logout();
    // TODO(PKeviin): show popup
  }
}
