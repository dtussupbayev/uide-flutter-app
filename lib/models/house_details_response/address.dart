import 'package:json_annotation/json_annotation.dart';

import 'city.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String? id;
  String? postalCode;
  String? name;
  String? description;
  City? city;

  Address({
    this.id,
    this.postalCode,
    this.name,
    this.description,
    this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
