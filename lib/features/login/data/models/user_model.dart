import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/session.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
class UserModel extends User {
  UserModel({
    required super.name,
    required super.lastName,
    required super.email,
    super.id,
    this.token,
    this.mobile,
  }) : super(session: Session(token: token));

  /// Connect the generated [_$UserModelFromJson] function to the `fromJson`
  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  final String? token;
  final String? mobile;

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
