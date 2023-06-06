import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'author.dart';
import 'photo.dart';

part 'house_entity.g.dart';

@JsonSerializable()
class HouseEntity {
  String? id;
  String? typeOfHouse;
  Author? author;
  String description;
  double price;
  int? numberOfResidents;
  String? createdAt;
  Address address;
  int? area;
  int? numberOfRooms;
  int? floor;
  List<Photo>? photos;
  bool? active;
  bool? checked;

  HouseEntity({
    this.id,
    this.typeOfHouse,
    this.author,
    required this.description,
    required this.price,
    this.numberOfResidents,
    this.createdAt,
    required this.address,
    this.area,
    this.numberOfRooms,
    this.floor,
    this.photos,
    this.active,
    this.checked,
  });

  @override
  String toString() {
    return 'HouseEntity(id: $id, typeOfHouse: $typeOfHouse, author: $author, description: $description, price: $price, numberOfResidents: $numberOfResidents, createdAt: $createdAt, address: $address, area: $area, numberOfRooms: $numberOfRooms, floor: $floor, photos: $photos, active: $active, checked: $checked)';
  }

  factory HouseEntity.fromJson(Map<String, dynamic> json) {
    return _$HouseEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HouseEntityToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! HouseEntity) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      typeOfHouse.hashCode ^
      author.hashCode ^
      description.hashCode ^
      price.hashCode ^
      numberOfResidents.hashCode ^
      createdAt.hashCode ^
      address.hashCode ^
      area.hashCode ^
      numberOfRooms.hashCode ^
      floor.hashCode ^
      photos.hashCode ^
      active.hashCode ^
      checked.hashCode;
}
