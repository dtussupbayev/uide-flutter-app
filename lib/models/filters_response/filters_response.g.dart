// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiltersResponse _$FiltersResponseFromJson(Map<String, dynamic> json) =>
    FiltersResponse(
      priceMinValue: (json['priceMinValue'] as num?)?.toDouble(),
      priceMaxValue: (json['priceMaxValue'] as num?)?.toDouble(),
      maxNumberOfResidence: json['maxNumberOfResidence'] as int?,
      minNumberOfResidence: json['minNumberOfResidence'] as int?,
      typeOfHouseList: (json['typeOfHouseList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FiltersResponseToJson(FiltersResponse instance) =>
    <String, dynamic>{
      'priceMinValue': instance.priceMinValue,
      'priceMaxValue': instance.priceMaxValue,
      'maxNumberOfResidence': instance.maxNumberOfResidence,
      'minNumberOfResidence': instance.minNumberOfResidence,
      'typeOfHouseList': instance.typeOfHouseList,
    };
