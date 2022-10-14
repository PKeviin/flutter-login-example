import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/impl/secure_storage/secure_storage_provider.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../data/datasources/login_local_data_source/login_local_data_source_impl.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../domain/usecases/check_user_has_already_logged_in.dart';

/// User has already logged in provider
final userHasAlreadyLoggedInProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  var hasAlreadyLoggedIn = false;
  final repository = LoginRepositoryImpl.locale(
    localDataSource: UserLocalDataSourceImpl(
      secureStorage: ref.watch(secureStorageImplProvider),
    ),
  );

  final failureOrUser =
      await CheckUserHasAlreadyLoggedIn(repository)(NoParams());
  failureOrUser.fold(
    (newFailure) {
      hasAlreadyLoggedIn = false;
    },
    (loggedIn) {
      hasAlreadyLoggedIn = loggedIn;
    },
  );
  return hasAlreadyLoggedIn;
});
