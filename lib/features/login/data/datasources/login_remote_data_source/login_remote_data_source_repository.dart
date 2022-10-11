//ignore: one_member_abstracts
import '../../models/user_model.dart';

abstract class LoginRemoteDataSourceRepository {
  Future<UserModel>? login();
}
