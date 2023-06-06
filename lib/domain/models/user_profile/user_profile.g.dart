// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] as String?,
      photo: json['photo'],
      hobbies: json['hobbies'] as List<dynamic>?,
      socialMediaProfiles: json['socialMediaProfiles'] as List<dynamic>?,
      description: json['description'],
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'],
      gender: json['gender'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
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
