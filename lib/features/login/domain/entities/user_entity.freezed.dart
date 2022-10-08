// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return _UserEntity.fromJson(json);
}

/// @nodoc
mixin _$UserEntity {
  String get name => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  SessionEntity get session => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get mobile => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  String? get localization => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserEntityCopyWith<UserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEntityCopyWith<$Res> {
  factory $UserEntityCopyWith(
          UserEntity value, $Res Function(UserEntity) then) =
      _$UserEntityCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String lastName,
      String email,
      SessionEntity session,
      int? id,
      String? mobile,
      bool isValid,
      String? localization});

  $SessionEntityCopyWith<$Res> get session;
}

/// @nodoc
class _$UserEntityCopyWithImpl<$Res> implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._value, this._then);

  final UserEntity _value;
  // ignore: unused_field
  final $Res Function(UserEntity) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? session = freezed,
    Object? id = freezed,
    Object? mobile = freezed,
    Object? isValid = freezed,
    Object? localization = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      session: session == freezed
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as SessionEntity,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      mobile: mobile == freezed
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      isValid: isValid == freezed
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      localization: localization == freezed
          ? _value.localization
          : localization // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $SessionEntityCopyWith<$Res> get session {
    return $SessionEntityCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc
abstract class _$$_UserEntityCopyWith<$Res>
    implements $UserEntityCopyWith<$Res> {
  factory _$$_UserEntityCopyWith(
          _$_UserEntity value, $Res Function(_$_UserEntity) then) =
      __$$_UserEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String lastName,
      String email,
      SessionEntity session,
      int? id,
      String? mobile,
      bool isValid,
      String? localization});

  @override
  $SessionEntityCopyWith<$Res> get session;
}

/// @nodoc
class __$$_UserEntityCopyWithImpl<$Res> extends _$UserEntityCopyWithImpl<$Res>
    implements _$$_UserEntityCopyWith<$Res> {
  __$$_UserEntityCopyWithImpl(
      _$_UserEntity _value, $Res Function(_$_UserEntity) _then)
      : super(_value, (v) => _then(v as _$_UserEntity));

  @override
  _$_UserEntity get _value => super._value as _$_UserEntity;

  @override
  $Res call({
    Object? name = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? session = freezed,
    Object? id = freezed,
    Object? mobile = freezed,
    Object? isValid = freezed,
    Object? localization = freezed,
  }) {
    return _then(_$_UserEntity(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      session: session == freezed
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as SessionEntity,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      mobile: mobile == freezed
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      isValid: isValid == freezed
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      localization: localization == freezed
          ? _value.localization
          : localization // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserEntity implements _UserEntity {
  const _$_UserEntity(
      {required this.name,
      required this.lastName,
      required this.email,
      required this.session,
      this.id,
      this.mobile,
      this.isValid = false,
      this.localization});

  factory _$_UserEntity.fromJson(Map<String, dynamic> json) =>
      _$$_UserEntityFromJson(json);

  @override
  final String name;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final SessionEntity session;
  @override
  final int? id;
  @override
  final String? mobile;
  @override
  @JsonKey()
  final bool isValid;
  @override
  final String? localization;

  @override
  String toString() {
    return 'UserEntity(name: $name, lastName: $lastName, email: $email, session: $session, id: $id, mobile: $mobile, isValid: $isValid, localization: $localization)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserEntity &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.session, session) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.mobile, mobile) &&
            const DeepCollectionEquality().equals(other.isValid, isValid) &&
            const DeepCollectionEquality()
                .equals(other.localization, localization));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(session),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(mobile),
      const DeepCollectionEquality().hash(isValid),
      const DeepCollectionEquality().hash(localization));

  @JsonKey(ignore: true)
  @override
  _$$_UserEntityCopyWith<_$_UserEntity> get copyWith =>
      __$$_UserEntityCopyWithImpl<_$_UserEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserEntityToJson(
      this,
    );
  }
}

abstract class _UserEntity implements UserEntity {
  const factory _UserEntity(
      {required final String name,
      required final String lastName,
      required final String email,
      required final SessionEntity session,
      final int? id,
      final String? mobile,
      final bool isValid,
      final String? localization}) = _$_UserEntity;

  factory _UserEntity.fromJson(Map<String, dynamic> json) =
      _$_UserEntity.fromJson;

  @override
  String get name;
  @override
  String get lastName;
  @override
  String get email;
  @override
  SessionEntity get session;
  @override
  int? get id;
  @override
  String? get mobile;
  @override
  bool get isValid;
  @override
  String? get localization;
  @override
  @JsonKey(ignore: true)
  _$$_UserEntityCopyWith<_$_UserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
