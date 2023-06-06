import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  String? id;
  String? email;
  String? createdAt;
  String? photo;
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

  @override
  String toString() {
    return 'Author(id: $id, email: $email, createdAt: $createdAt, photo: $photo, hobbies: $hobbies, socialMediaProfiles: $socialMediaProfiles, description: $description, phoneNumber: $phoneNumber, role: $role, gender: $gender, active: $active)';
  }

  factory Author.fromJson(Map<String, dynamic> json) {
    return _$AuthorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Author) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      photo.hashCode ^
      hobbies.hashCode ^
      socialMediaProfiles.hashCode ^
      description.hashCode ^
      phoneNumber.hashCode ^
      role.hashCode ^
      gender.hashCode ^
      active.hashCode;
}
