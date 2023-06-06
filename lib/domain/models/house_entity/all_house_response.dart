import 'package:json_annotation/json_annotation.dart';
import 'package:uide/domain/models/house_entity/house_entity.dart';

import 'pageable.dart';
import 'sort.dart';

part 'all_house_response.g.dart';

@JsonSerializable()
class AllHousesResponse {
  List<HouseEntity>? content;
  Pageable? pageable;
  int? totalElements;
  int? totalPages;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  AllHousesResponse({
    this.content,
    this.pageable,
    this.totalElements,
    this.totalPages,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  factory AllHousesResponse.fromJson(Map<String, dynamic> json) {
    return _$AllHousesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllHousesResponseToJson(this);
}
