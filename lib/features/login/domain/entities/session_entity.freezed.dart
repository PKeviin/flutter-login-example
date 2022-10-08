// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'session_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionEntity _$SessionEntityFromJson(Map<String, dynamic> json) {
  return _SessionEntity.fromJson(json);
}

/// @nodoc
mixin _$SessionEntity {
  String? get token => throw _privateConstructorUsedError;
  String? get currentLocation => throw _privateConstructorUsedError;
  String? get previousLocation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionEntityCopyWith<SessionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionEntityCopyWith<$Res> {
  factory $SessionEntityCopyWith(
          SessionEntity value, $Res Function(SessionEntity) then) =
      _$SessionEntityCopyWithImpl<$Res>;
  $Res call({String? token, String? currentLocation, String? previousLocation});
}

/// @nodoc
class _$SessionEntityCopyWithImpl<$Res>
    implements $SessionEntityCopyWith<$Res> {
  _$SessionEntityCopyWithImpl(this._value, this._then);

  final SessionEntity _value;
  // ignore: unused_field
  final $Res Function(SessionEntity) _then;

  @override
  $Res call({
    Object? token = freezed,
    Object? currentLocation = freezed,
    Object? previousLocation = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLocation: currentLocation == freezed
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      previousLocation: previousLocation == freezed
          ? _value.previousLocation
          : previousLocation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_SessionEntityCopyWith<$Res>
    implements $SessionEntityCopyWith<$Res> {
  factory _$$_SessionEntityCopyWith(
          _$_SessionEntity value, $Res Function(_$_SessionEntity) then) =
      __$$_SessionEntityCopyWithImpl<$Res>;
  @override
  $Res call({String? token, String? currentLocation, String? previousLocation});
}

/// @nodoc
class __$$_SessionEntityCopyWithImpl<$Res>
    extends _$SessionEntityCopyWithImpl<$Res>
    implements _$$_SessionEntityCopyWith<$Res> {
  __$$_SessionEntityCopyWithImpl(
      _$_SessionEntity _value, $Res Function(_$_SessionEntity) _then)
      : super(_value, (v) => _then(v as _$_SessionEntity));

  @override
  _$_SessionEntity get _value => super._value as _$_SessionEntity;

  @override
  $Res call({
    Object? token = freezed,
    Object? currentLocation = freezed,
    Object? previousLocation = freezed,
  }) {
    return _then(_$_SessionEntity(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLocation: currentLocation == freezed
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      previousLocation: previousLocation == freezed
          ? _value.previousLocation
          : previousLocation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SessionEntity implements _SessionEntity {
  const _$_SessionEntity(
      {this.token, this.currentLocation, this.previousLocation});

  factory _$_SessionEntity.fromJson(Map<String, dynamic> json) =>
      _$$_SessionEntityFromJson(json);

  @override
  final String? token;
  @override
  final String? currentLocation;
  @override
  final String? previousLocation;

  @override
  String toString() {
    return 'SessionEntity(token: $token, currentLocation: $currentLocation, previousLocation: $previousLocation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionEntity &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality()
                .equals(other.currentLocation, currentLocation) &&
            const DeepCollectionEquality()
                .equals(other.previousLocation, previousLocation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(currentLocation),
      const DeepCollectionEquality().hash(previousLocation));

  @JsonKey(ignore: true)
  @override
  _$$_SessionEntityCopyWith<_$_SessionEntity> get copyWith =>
      __$$_SessionEntityCopyWithImpl<_$_SessionEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionEntityToJson(
      this,
    );
  }
}

abstract class _SessionEntity implements SessionEntity {
  const factory _SessionEntity(
      {final String? token,
      final String? currentLocation,
      final String? previousLocation}) = _$_SessionEntity;

  factory _SessionEntity.fromJson(Map<String, dynamic> json) =
      _$_SessionEntity.fromJson;

  @override
  String? get token;
  @override
  String? get currentLocation;
  @override
  String? get previousLocation;
  @override
  @JsonKey(ignore: true)
  _$$_SessionEntityCopyWith<_$_SessionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
