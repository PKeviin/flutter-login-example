// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'api_response_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

APIJsonResponse _$APIJsonResponseFromJson(Map<String, dynamic> json) {
  return _APIJsonResponse.fromJson(json);
}

/// @nodoc
mixin _$APIJsonResponse {
  dynamic get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get error => throw _privateConstructorUsedError;
  bool get unauthorized => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $APIJsonResponseCopyWith<APIJsonResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIJsonResponseCopyWith<$Res> {
  factory $APIJsonResponseCopyWith(
          APIJsonResponse value, $Res Function(APIJsonResponse) then) =
      _$APIJsonResponseCopyWithImpl<$Res>;
  $Res call(
      {dynamic data,
      String message,
      bool error,
      bool unauthorized,
      int statusCode});
}

/// @nodoc
class _$APIJsonResponseCopyWithImpl<$Res>
    implements $APIJsonResponseCopyWith<$Res> {
  _$APIJsonResponseCopyWithImpl(this._value, this._then);

  final APIJsonResponse _value;
  // ignore: unused_field
  final $Res Function(APIJsonResponse) _then;

  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
    Object? unauthorized = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      unauthorized: unauthorized == freezed
          ? _value.unauthorized
          : unauthorized // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: statusCode == freezed
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_APIJsonResponseCopyWith<$Res>
    implements $APIJsonResponseCopyWith<$Res> {
  factory _$$_APIJsonResponseCopyWith(
          _$_APIJsonResponse value, $Res Function(_$_APIJsonResponse) then) =
      __$$_APIJsonResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic data,
      String message,
      bool error,
      bool unauthorized,
      int statusCode});
}

/// @nodoc
class __$$_APIJsonResponseCopyWithImpl<$Res>
    extends _$APIJsonResponseCopyWithImpl<$Res>
    implements _$$_APIJsonResponseCopyWith<$Res> {
  __$$_APIJsonResponseCopyWithImpl(
      _$_APIJsonResponse _value, $Res Function(_$_APIJsonResponse) _then)
      : super(_value, (v) => _then(v as _$_APIJsonResponse));

  @override
  _$_APIJsonResponse get _value => super._value as _$_APIJsonResponse;

  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
    Object? unauthorized = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_$_APIJsonResponse(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      unauthorized: unauthorized == freezed
          ? _value.unauthorized
          : unauthorized // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: statusCode == freezed
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_APIJsonResponse extends _APIJsonResponse {
  const _$_APIJsonResponse(
      {this.data,
      this.message = '',
      this.error = false,
      this.unauthorized = false,
      this.statusCode = -1})
      : super._();

  factory _$_APIJsonResponse.fromJson(Map<String, dynamic> json) =>
      _$$_APIJsonResponseFromJson(json);

  @override
  final dynamic data;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final bool error;
  @override
  @JsonKey()
  final bool unauthorized;
  @override
  @JsonKey()
  final int statusCode;

  @override
  String toString() {
    return 'APIJsonResponse(data: $data, message: $message, error: $error, unauthorized: $unauthorized, statusCode: $statusCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_APIJsonResponse &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.unauthorized, unauthorized) &&
            const DeepCollectionEquality()
                .equals(other.statusCode, statusCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(unauthorized),
      const DeepCollectionEquality().hash(statusCode));

  @JsonKey(ignore: true)
  @override
  _$$_APIJsonResponseCopyWith<_$_APIJsonResponse> get copyWith =>
      __$$_APIJsonResponseCopyWithImpl<_$_APIJsonResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_APIJsonResponseToJson(
      this,
    );
  }
}

abstract class _APIJsonResponse extends APIJsonResponse {
  const factory _APIJsonResponse(
      {final dynamic data,
      final String message,
      final bool error,
      final bool unauthorized,
      final int statusCode}) = _$_APIJsonResponse;
  const _APIJsonResponse._() : super._();

  factory _APIJsonResponse.fromJson(Map<String, dynamic> json) =
      _$_APIJsonResponse.fromJson;

  @override
  dynamic get data;
  @override
  String get message;
  @override
  bool get error;
  @override
  bool get unauthorized;
  @override
  int get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$_APIJsonResponseCopyWith<_$_APIJsonResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
