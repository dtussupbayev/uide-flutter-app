import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'city.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String id;
  String? postalCode;
  String name;
  String description;
  City? city;

  Address({
    required this.id,
    this.postalCode,
    required this.name,
    required this.description,
    this.city,
  });

  @override
  String toString() {
    return 'Address(id: $id, postalCode: $postalCode, name: $name, description: $description, city: $city)';
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Address) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      postalCode.hashCode ^
      name.hashCode ^
      description.hashCode ^
      city.hashCode;
}
