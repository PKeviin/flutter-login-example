// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionEntity _$$_SessionEntityFromJson(Map<String, dynamic> json) =>
    _$_SessionEntity(
      token: json['token'] as String?,
      currentLocation: json['currentLocation'] as String?,
      previousLocation: json['previousLocation'] as String?,
    );

Map<String, dynamic> _$$_SessionEntityToJson(_$_SessionEntity instance) =>
    <String, dynamic>{
      'token': instance.token,
      'currentLocation': instance.currentLocation,
      'previousLocation': instance.previousLocation,
    };
