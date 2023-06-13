// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map<String, dynamic> json) => Payload(
      sub: json['sub'] as String?,
      iat: json['iat'] as int?,
      role: json['role'] as String?,
      email: json['email'] as String?,
      exp: json['exp'] as int?,
    );

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
      'sub': instance.sub,
      'iat': instance.iat,
      'role': instance.role,
      'email': instance.email,
      'exp': instance.exp,
    };
