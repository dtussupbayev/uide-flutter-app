import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'author.dart';
import 'photo.dart';

part 'house_details_response.g.dart';

@JsonSerializable()
class HouseDetailsResponse {
  String? id;
  String? typeOfHouse;
  Author? author;
  String? description;
  double? price;
  int? numberOfResidents;
  String? createdAt;
  Address? address;
  int? area;
  int? numberOfRooms;
  int? floor;
  List<Photo>? photos;
  bool? active;
  bool? checked;

  HouseDetailsResponse({
    this.id,
    this.typeOfHouse,
    this.author,
    this.description,
    this.price,
    this.numberOfResidents,
    this.createdAt,
    this.address,
    this.area,
    this.numberOfRooms,
    this.floor,
    this.photos,
    this.active,
    this.checked,
  });

  factory HouseDetailsResponse.fromJson(Map<String, dynamic> json) {
    return _$HouseDetailsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HouseDetailsResponseToJson(this);
}
