// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseEntity _$HouseEntityFromJson(Map<String, dynamic> json) => HouseEntity(
      id: json['id'] as String?,
      typeOfHouse: json['typeOfHouse'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      numberOfResidents: json['numberOfResidents'] as int?,
      createdAt: json['createdAt'] as String?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      area: json['area'] as int?,
      numberOfRooms: json['numberOfRooms'] as int?,
      floor: json['floor'] as int?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      active: json['active'] as bool?,
      checked: json['checked'] as bool?,
    );

Map<String, dynamic> _$HouseEntityToJson(HouseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeOfHouse': instance.typeOfHouse,
      'author': instance.author,
      'description': instance.description,
      'price': instance.price,
      'numberOfResidents': instance.numberOfResidents,
      'createdAt': instance.createdAt,
      'address': instance.address,
      'area': instance.area,
      'numberOfRooms': instance.numberOfRooms,
      'floor': instance.floor,
      'photos': instance.photos,
      'active': instance.active,
      'checked': instance.checked,
    };
