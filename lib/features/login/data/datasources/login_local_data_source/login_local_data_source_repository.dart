import '../../models/user_model.dart';

abstract class LoginLocalDataSourceRepository {
  Future<void>? cacheUser(UserModel? user);
  Future<UserModel>? getUser();
  Future<void> removeUser();
}
