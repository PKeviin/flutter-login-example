import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/datasources/user_local_data_source/user_local_data_source_impl.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../domain/usecases/login_user.dart';

/// User has already logged in provider
final userHasAlreadyLoggedInProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  var hasAlreadyLoggedIn = false;
  final userLocalDataSourceImpl = ref.watch(userLocalDataSourceImplProvider);
  final repository = LoginRepositoryImpl.locale(
    localDataSource: userLocalDataSourceImpl,
  );

  final failureOrUser = await LoginUser(repository).loginLocaleUser(NoParams());
  failureOrUser?.fold(
    (newFailure) {
      hasAlreadyLoggedIn = false;
    },
    (user) {
      hasAlreadyLoggedIn = true;
    },
  );
  return hasAlreadyLoggedIn;
});
