import 'package:json_annotation/json_annotation.dart';

part 'payload.g.dart';

@JsonSerializable()
class Payload {
  String? sub;
  int? iat;
  String? role;
  String? email;
  int? exp;

  Payload({this.sub, this.iat, this.role, this.email, this.exp});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return _$PayloadFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}
