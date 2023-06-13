import 'package:json_annotation/json_annotation.dart';

part 'filters_response.g.dart';

@JsonSerializable()
class FiltersResponse {
  double? priceMinValue;
  double? priceMaxValue;
  int? maxNumberOfResidence;
  int? minNumberOfResidence;
  List<String>? typeOfHouseList;

  FiltersResponse({
    this.priceMinValue,
    this.priceMaxValue,
    this.maxNumberOfResidence,
    this.minNumberOfResidence,
    this.typeOfHouseList,
  });

  factory FiltersResponse.fromJson(Map<String, dynamic> json) {
    return _$FiltersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FiltersResponseToJson(this);
}
