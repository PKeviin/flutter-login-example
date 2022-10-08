// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_APIJsonResponse _$$_APIJsonResponseFromJson(Map<String, dynamic> json) =>
    _$_APIJsonResponse(
      data: json['data'],
      message: json['message'] as String? ?? '',
      error: json['error'] as bool? ?? false,
      unauthorized: json['unauthorized'] as bool? ?? false,
      statusCode: json['statusCode'] as int? ?? -1,
    );

Map<String, dynamic> _$$_APIJsonResponseToJson(_$_APIJsonResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'error': instance.error,
      'unauthorized': instance.unauthorized,
      'statusCode': instance.statusCode,
    };
