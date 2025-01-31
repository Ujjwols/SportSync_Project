// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      teamname: json['teamname'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      password: json['password'] as String?,
      confrimpassword: json['confrimpassword'] as String?,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'teamname': instance.teamname,
      'email': instance.email,
      'image': instance.image,
      'password': instance.password,
      'confrimpassword': instance.confrimpassword,
    };
