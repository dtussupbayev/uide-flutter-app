// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    UserProfileResponse(
      id: json['id'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] as String?,
      photo: json['photo'] as String?,
      hobbies: (json['hobbies'] as List<dynamic>?)
          ?.map((e) => Hobby.fromJson(e as Map<String, dynamic>))
          .toList(),
      socialMediaProfiles: json['socialMediaProfiles'] as List<dynamic>?,
      description: json['description'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
      gender: json['gender'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$UserProfileResponseToJson(
        UserProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'photo': instance.photo,
      'hobbies': instance.hobbies,
      'socialMediaProfiles': instance.socialMediaProfiles,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'gender': instance.gender,
      'active': instance.active,
    };
