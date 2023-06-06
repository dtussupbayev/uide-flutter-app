// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_house_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllHousesResponse _$AllHousesResponseFromJson(Map<String, dynamic> json) =>
    AllHousesResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => HouseEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable: json['pageable'] == null
          ? null
          : Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
      totalElements: json['totalElements'] as int?,
      totalPages: json['totalPages'] as int?,
      last: json['last'] as bool?,
      size: json['size'] as int?,
      number: json['number'] as int?,
      sort: json['sort'] == null
          ? null
          : Sort.fromJson(json['sort'] as Map<String, dynamic>),
      numberOfElements: json['numberOfElements'] as int?,
      first: json['first'] as bool?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$AllHousesResponseToJson(AllHousesResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'last': instance.last,
      'size': instance.size,
      'number': instance.number,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'first': instance.first,
      'empty': instance.empty,
    };
