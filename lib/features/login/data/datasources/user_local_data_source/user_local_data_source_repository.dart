import '../../models/user_model.dart';

abstract class UserLocalDataSourceRepository {
  Future<void>? saveUser(UserModel? user);
  Future<UserModel>? getUser();
  Future<void> removeUser();
}
