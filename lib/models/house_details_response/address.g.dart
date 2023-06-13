// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String?,
      postalCode: json['postalCode'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'postalCode': instance.postalCode,
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
    };
