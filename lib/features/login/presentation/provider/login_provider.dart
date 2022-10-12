import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/impl/local_auth/local_auth_provider.dart';
import '../../../../core/impl/local_auth/local_auth_repository.dart';
import '../../../../core/impl/network_info/network_info_provider.dart';
import '../../../../core/impl/network_info/network_info_repository.dart';
import '../../../../core/providers/failure_provider.dart';
import '../../../../core/providers/loader_provider.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/errors/failures.dart';
import '../../data/datasources/login_remote_data_source/fake_login_remote_data_source_impl.dart';
import '../../data/datasources/login_remote_data_source/login_remote_data_source_repository.dart';
import '../../data/datasources/user_local_data_source/user_local_data_source_impl.dart';
import '../../data/datasources/user_local_data_source/user_local_data_source_repository.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../data/repositories/logout_repository_impl.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import 'user_provider.dart';

final passwordProvider = StateProvider.autoDispose<String>((ref) => '');
final identifiantProvider = StateProvider.autoDispose<String>((ref) => '');

/// Login provider
final loginProvider =
    StateNotifierProvider.autoDispose<LoginState, bool?>((ref) {
  final userState = ref.watch(userProvider.notifier);
  final failureState = ref.watch(failureProvider.notifier);
  final loaderState = ref.watch(loaderProvider.notifier);
  final localAuth = ref.watch(localAuthImplProvider);
  final networkInfo = ref.watch(networkInfoImplProvider);
  final userLocalDataSourceImpl = ref.watch(userLocalDataSourceImplProvider);
  // Implementation of a fake login
  // Using LoginRemoteDataSourceImpl to implement real login
  final fakeLoginRemoteDataSourceImpl =
      ref.watch(fakeLoginRemoteDataSourceImplProvider);
  return LoginState(
    userState: userState,
    failureState: failureState,
    loaderState: loaderState,
    localAuth: localAuth,
    userLocalDataSourceImpl: userLocalDataSourceImpl,
    networkInfoImpl: networkInfo,
    loginRemoteDataSourceImpl: fakeLoginRemoteDataSourceImpl,
  );
});

class LoginState extends StateNotifier<bool?> {
  LoginState({
    required this.userState,
    required this.loaderState,
    required this.failureState,
    required this.localAuth,
    required this.userLocalDataSourceImpl,
    required this.networkInfoImpl,
    required this.loginRemoteDataSourceImpl,
  }) : super(null);
  UserState userState;
  StateController<Failure?> failureState;
  StateController<bool> loaderState;
  LocalAuthRepository localAuth;
  NetworkInfoRepository networkInfoImpl;
  LoginRemoteDataSourceRepository loginRemoteDataSourceImpl;
  UserLocalDataSourceRepository userLocalDataSourceImpl;

  /// User locale session
  Future<void> eitherFailureOrLoginLocaleUser() async {
    final repository = LoginRepositoryImpl.locale(
      localDataSource: userLocalDataSourceImpl,
    );

    final failureOrUser =
        await LoginUser(repository).loginLocaleUser(NoParams());

    await failureOrUser?.fold(
      (newFailure) {
        userState.state = null;
        // Disabling user fetch error in cache
        // The error may be triggered each time the app is launched even
        // if it is the first start
        // failureState.state = newFailure;
      },
      (user) async {
        final hasBiometrics = await localAuth.hasBiometrics;
        if (!hasBiometrics ||
            (hasBiometrics && await localAuth.hasLocalAuthenticate)) {
          userState.state = user;
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
      remoteDataSource: loginRemoteDataSourceImpl,
      localDataSource: userLocalDataSourceImpl,
      networkInfo: networkInfoImpl,
    );

    final failureOrUser = await LoginUser(repository).loginUser(NoParams());

    failureOrUser?.fold(
      (newFailure) {
        userState.state = null;
        failureState.state = newFailure;
      },
      (user) {
        userState.state = user;
        failureState.state = null;
      },
    );
    loaderState.state = false;
  }

  /// Logout user
  Future<void> logout() async {
    loaderState.state = true;
    final repository = LogoutRepositoryImpl(
      localDataSource: userLocalDataSourceImpl,
    );

    final failureOrSession =
        await LogoutUser(repository).logoutUser(NoParams());

    failureOrSession?.fold(
      (newFailure) {
        failureState.state = newFailure;
      },
      (isOk) {
        userState.state = null;
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