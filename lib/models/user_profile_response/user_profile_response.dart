import 'package:json_annotation/json_annotation.dart';

import 'hobby.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  String? id;
  String? email;
  String? createdAt;
  String? photo;
  List<Hobby>? hobbies;
  List<dynamic>? socialMediaProfiles;
  String? description;
  String? phoneNumber;
  String? role;
  String? gender;
  bool? active;

  UserProfileResponse({
    this.id,
    this.email,
    this.createdAt,
    this.photo,
    this.hobbies,
    this.socialMediaProfiles,
    this.description,
    this.phoneNumber,
    this.role,
    this.gender,
    this.active,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$UserProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
