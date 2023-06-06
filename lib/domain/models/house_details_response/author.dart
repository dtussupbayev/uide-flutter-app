import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
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

  Author({
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

  factory Author.fromJson(Map<String, dynamic> json) {
    return _$AuthorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
