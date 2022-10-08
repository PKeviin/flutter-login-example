import 'package:freezed_annotation/freezed_annotation.dart';
import 'session_entity.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String name,
    required String lastName,
    required String email,
    required SessionEntity session,
    int? id,
    String? mobile,
    @Default(false) bool isValid,
    String? localization,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, Object?> json) =>
      _$UserEntityFromJson(json);
}
