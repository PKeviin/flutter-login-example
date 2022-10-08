// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserEntity _$$_UserEntityFromJson(Map<String, dynamic> json) =>
    _$_UserEntity(
      id: json['id'] as int?,
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      session: SessionEntity.fromJson(json['session'] as Map<String, dynamic>),
      mobile: json['mobile'] as String?,
      isValid: json['isValid'] as bool? ?? false,
      localization: json['localization'] as String?,
    );

Map<String, dynamic> _$$_UserEntityToJson(_$_UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastName': instance.lastName,
      'email': instance.email,
      'session': instance.session,
      'mobile': instance.mobile,
      'isValid': instance.isValid,
      'localization': instance.localization,
    };
