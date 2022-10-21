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

/// @nodoc
mixin _$APIJsonResponse {
  dynamic get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get messageEn => throw _privateConstructorUsedError;
  bool get error => throw _privateConstructorUsedError;
  bool get unauthorized => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $APIJsonResponseCopyWith<APIJsonResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIJsonResponseCopyWith<$Res> {
  factory $APIJsonResponseCopyWith(
          APIJsonResponse value, $Res Function(APIJsonResponse) then) =
      _$APIJsonResponseCopyWithImpl<$Res, APIJsonResponse>;
  @useResult
  $Res call(
      {dynamic data,
      String message,
      String messageEn,
      bool error,
      bool unauthorized,
      int statusCode});
}

/// @nodoc
class _$APIJsonResponseCopyWithImpl<$Res, $Val extends APIJsonResponse>
    implements $APIJsonResponseCopyWith<$Res> {
  _$APIJsonResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? messageEn = null,
    Object? error = null,
    Object? unauthorized = null,
    Object? statusCode = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      messageEn: null == messageEn
          ? _value.messageEn
          : messageEn // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      unauthorized: null == unauthorized
          ? _value.unauthorized
          : unauthorized // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_APIJsonResponseCopyWith<$Res>
    implements $APIJsonResponseCopyWith<$Res> {
  factory _$$_APIJsonResponseCopyWith(
          _$_APIJsonResponse value, $Res Function(_$_APIJsonResponse) then) =
      __$$_APIJsonResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic data,
      String message,
      String messageEn,
      bool error,
      bool unauthorized,
      int statusCode});
}

/// @nodoc
class __$$_APIJsonResponseCopyWithImpl<$Res>
    extends _$APIJsonResponseCopyWithImpl<$Res, _$_APIJsonResponse>
    implements _$$_APIJsonResponseCopyWith<$Res> {
  __$$_APIJsonResponseCopyWithImpl(
      _$_APIJsonResponse _value, $Res Function(_$_APIJsonResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? messageEn = null,
    Object? error = null,
    Object? unauthorized = null,
    Object? statusCode = null,
  }) {
    return _then(_$_APIJsonResponse(
      data: null == data ? _value.data : data,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      messageEn: null == messageEn
          ? _value.messageEn
          : messageEn // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      unauthorized: null == unauthorized
          ? _value.unauthorized
          : unauthorized // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_APIJsonResponse extends _APIJsonResponse {
  const _$_APIJsonResponse(
      {this.data,
      this.message = '',
      this.messageEn = '',
      this.error = false,
      this.unauthorized = false,
      this.statusCode = -1})
      : super._();

  @override
  final dynamic data;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String messageEn;
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
    return 'APIJsonResponse(data: $data, message: $message, messageEn: $messageEn, error: $error, unauthorized: $unauthorized, statusCode: $statusCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_APIJsonResponse &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.messageEn, messageEn) ||
                other.messageEn == messageEn) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.unauthorized, unauthorized) ||
                other.unauthorized == unauthorized) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      message,
      messageEn,
      error,
      unauthorized,
      statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_APIJsonResponseCopyWith<_$_APIJsonResponse> get copyWith =>
      __$$_APIJsonResponseCopyWithImpl<_$_APIJsonResponse>(this, _$identity);
}

abstract class _APIJsonResponse extends APIJsonResponse {
  const factory _APIJsonResponse(
      {final dynamic data,
      final String message,
      final String messageEn,
      final bool error,
      final bool unauthorized,
      final int statusCode}) = _$_APIJsonResponse;
  const _APIJsonResponse._() : super._();

  @override
  dynamic get data;
  @override
  String get message;
  @override
  String get messageEn;
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
