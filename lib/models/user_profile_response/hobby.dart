import 'package:json_annotation/json_annotation.dart';

part 'hobby.g.dart';

@JsonSerializable()
class Hobby {
  String? id;
  String? name;
  String? description;

  Hobby({this.id, this.name, this.description});

  factory Hobby.fromJson(Map<String, dynamic> json) => _$HobbyFromJson(json);

  Map<String, dynamic> toJson() => _$HobbyToJson(this);
}
