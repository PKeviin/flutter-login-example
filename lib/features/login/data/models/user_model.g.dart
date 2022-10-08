// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      id: json['id'] as int?,
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'email': instance.email,
      'token': instance.token,
      'id': instance.id,
      'mobile': instance.mobile,
    };
