import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_entity.freezed.dart';
part 'session_entity.g.dart';

@freezed
class SessionEntity with _$SessionEntity {
  const factory SessionEntity({
    String? token,
    String? currentLocation,
    String? previousLocation,
  }) = _SessionEntity;

  factory SessionEntity.fromJson(Map<String, Object?> json) =>
      _$SessionEntityFromJson(json);
}
