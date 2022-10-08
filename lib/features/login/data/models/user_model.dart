import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/session_entity.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String name,
    required String lastName,
    required String email,
    required String token,
    int? id,
    String? mobile,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
  const UserModel._();

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        lastName: lastName,
        email: email,
        mobile: mobile,
        session: SessionEntity(token: token),
      );
}
