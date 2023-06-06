import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  String? id;
  String? email;
  String? createdAt;
  dynamic photo;
  List<dynamic>? hobbies;
  List<dynamic>? socialMediaProfiles;
  dynamic description;
  String? phoneNumber;
  dynamic role;
  String? gender;
  bool? active;

  UserProfile({
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

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return _$UserProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
