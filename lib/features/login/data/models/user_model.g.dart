// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      id: json['id'] as int?,
      token: json['token'] as String?,
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'email': instance.email,
      'id': instance.id,
      'token': instance.token,
      'mobile': instance.mobile,
    };
